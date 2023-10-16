package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.constant.MailConstant;
import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.exception.FileSizeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.FileTypeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.dto.DataMailDto;
import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.PageUserListRespone;
import com.shsoftvina.erpshsoftvina.model.response.user.UserShowResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import com.shsoftvina.erpshsoftvina.utils.SendMailUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserConverter userConverter;

    @Autowired
    private SendMailUtils sendMailUtils;

    @Autowired
    private HttpServletRequest request;

    @Override
    public PageUserListRespone getAllUser(String searchTerm, String sortDirection, int start, int pageSize, String status) {

        int offset = (start - 1) * pageSize;
        RowBounds rowBounds = new RowBounds(offset, pageSize);
        List<User> users = userMapper.getAllUser(searchTerm, sortDirection, status, rowBounds);
        List<UserShowResponse> showUsers = userConverter.toListShowUserResponse(users);
        long totalRecordCount = userMapper.getTotalUser(status, searchTerm, sortDirection);
        long totalPage = (long) Math.ceil((double) totalRecordCount / pageSize);
        boolean hasNext = start < totalPage;
        boolean hasPrevious = start > 1;

        return new PageUserListRespone(showUsers, start, totalPage, pageSize, hasNext, hasPrevious);
    }

    @Override
    public UserDetailResponse findUserDetail(String id) {
        User s = null;
        try {
            s = userMapper.findById(id);
        } catch (Exception e) {

        }
        return userConverter.toUserDetailResponse(s);
    }

    @Override
    public int deleteUser(String id) {
        return userMapper.changeStatusUser(id, (StatusUserEnum.INACTIVE).toString());
    }

    @Override
    public Boolean activeUserRegisterRequest(UserActiveRequest userActiveRequest) {

        if (!EnumUtils.isExistInEnum(RoleEnum.class, userActiveRequest.getRole()))
            throw new NotFoundException(MessageErrorUtils.notFound("Role"));
        if (!EnumUtils.isExistInEnum(StatusUserEnum.class, userActiveRequest.getStatus()))
            throw new NotFoundException(MessageErrorUtils.notFound("Status"));

        if (userActiveRequest.getStatus().equals(StatusUserEnum.REJECT)) {
            try {
                userMapper.deleteUser(userActiveRequest.getId());
                return true;
            } catch (Exception e) {
                return false;
            }
        } else {
            User user = userConverter.toEntity(userActiveRequest);

            try {
                userMapper.activeUserRegister(user);

                DataMailDto dataMailDto = new DataMailDto();
                dataMailDto.setTo(userActiveRequest.getEmail());
                dataMailDto.setSubject(MailConstant.REGISTER_SUBJECT);
                dataMailDto.setContent(MailConstant.REGISTER_CONTENT);
                return sendMailUtils.sendEmail(dataMailDto);
            } catch (Exception e) {
            }
            return false;
        }
    }

    @Override
    public UserDetailResponse findByEmail(String email) {
        User user = userMapper.findByEmail(email);
        if (user == null) return null;
        return userConverter.toUserDetailResponse(user);
    }

    @Override
    public int updateUserDetail(UserUpdateRequest userUpdateRequest) {

        String id = userUpdateRequest.getId();
        User user = userMapper.findById(id);

        if (user == null) throw new NotFoundException(MessageErrorUtils.notFound("Id"));

        MultipartFile avatarFile = userUpdateRequest.getAvatar();
        MultipartFile resumeFile = userUpdateRequest.getResume();

        if (avatarFile != null) {
            if (!FileUtils.isAllowedFileType(avatarFile, ApplicationConstant.LIST_TYPE_IMAGE))
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowImageType());
            if (!FileUtils.isAllowedFileSize(avatarFile))
                throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize());
        }
        if (resumeFile != null) {
            if (!FileUtils.isAllowedFileType(resumeFile, ApplicationConstant.LIST_TYPE_FILE))
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType());
            if (!FileUtils.isAllowedFileSize(resumeFile))
                throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize());
        }

        String uploadDir = UserConstant.UPLOAD_FILE_DIR;
        List<String> newFileNameList = FileUtils.saveMultipleFilesToServer(request,
                uploadDir, avatarFile, resumeFile);

        if (newFileNameList != null) {
            String avatarNameOld = user.getAvatar();
            String resumeNameOld = user.getResume();

            User userUpdate = null;
            if (Principal.getUserCurrent().getRole().equals(RoleEnum.DEVELOPER)) {
                if(newFileNameList.size() == 1){
                    if(avatarFile != null) userUpdate = userConverter.toUpdateBasic(userUpdateRequest, newFileNameList.get(0), null);
                    else if(resumeFile != null) userUpdate = userConverter.toUpdateBasic(userUpdateRequest, null, newFileNameList.get(0));
                } else if(newFileNameList.size() == 2){
                    userUpdate = userConverter.toUpdateBasic(userUpdateRequest, newFileNameList.get(0), newFileNameList.get(1));
                } else{ // = 0, no avatar and resume
                    userUpdate = userConverter.toUpdateBasic(userUpdateRequest, null, null);
                    userUpdate.setAvatar(user.getAvatar());
                    userUpdate.setResume(user.getResume());
                }
            } else{
                if(newFileNameList.size() == 1){
                    if(avatarFile != null) userUpdate = userConverter.toUpdateDetail(userUpdateRequest, newFileNameList.get(0), null);
                    else if(resumeFile != null) userUpdate = userConverter.toUpdateDetail(userUpdateRequest, null, newFileNameList.get(0));
                } else if(newFileNameList.size() == 2){
                    userUpdate = userConverter.toUpdateDetail(userUpdateRequest, newFileNameList.get(0), newFileNameList.get(1));
                } else{ // = 0, no avatar and resume
                    userUpdate = userConverter.toUpdateDetail(userUpdateRequest, null, null);
                    userUpdate.setAvatar(user.getAvatar());
                    userUpdate.setResume(user.getResume());
                }
            }

            try{
                if (Principal.getUserCurrent().getRole().equals(RoleEnum.DEVELOPER)) {
                    if (userUpdateRequest.getPassword() == null) userUpdate.setPassword(user.getPassword());
                    userMapper.updateUserProfile(userUpdate);
                } else{
                    if (userUpdateRequest.getPassword() == null) userUpdate.setPassword(user.getPassword());
                    userMapper.updateUserDetail(userUpdate);
                }

                if(avatarNameOld != null){
                    FileUtils.deleteImageFromServer(request, uploadDir, avatarNameOld);
                }
                if(resumeNameOld != null){
                    FileUtils.deleteImageFromServer(request, uploadDir, resumeNameOld);
                }
                return 1;
            } catch (Exception e){
                return 0;
            }
        }
        return 0;
    }

    @Override
    public List<Map<String, Object>> getAllFullname() {
        return userMapper.getAllFullname();
    }
}
