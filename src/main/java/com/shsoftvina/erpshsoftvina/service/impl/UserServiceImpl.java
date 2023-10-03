package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.constant.MailConstant;
import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.exception.DuplicateException;
import com.shsoftvina.erpshsoftvina.exception.FileSizeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.FileTypeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.dto.DataMailDto;
import com.shsoftvina.erpshsoftvina.model.request.user.*;
import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateProfileRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.UserShowRespone;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import com.shsoftvina.erpshsoftvina.utils.SendMailUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

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
    public List<UserShowRespone> getAllUser(String searchTerm,
                                            String sortDirection,
                                            int start,
                                            int pageSize,
                                            String status) {
        List<User> listUser = userMapper.getAllUser(searchTerm, sortDirection, start, pageSize, status);
        return userConverter.toListShowUserRespone(listUser);
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
    public void deleteUser(String id) {
        userMapper.changeStatusUser(id, (StatusUserEnum.INACTIVE).toString());
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
                    userUpdate = userConverter.toUpdateBasic(userUpdateRequest, newFileNameList.get(0), null);
                } else if(newFileNameList.size() == 2){
                    userUpdate = userConverter.toUpdateBasic(userUpdateRequest, newFileNameList.get(0), newFileNameList.get(1));
                }
            } else{
                if(newFileNameList.size() == 1){
                    userUpdate = userConverter.toUpdateDetail(userUpdateRequest, newFileNameList.get(0), null);
                } else if(newFileNameList.size() == 2){
                    userUpdate = userConverter.toUpdateDetail(userUpdateRequest, newFileNameList.get(0), newFileNameList.get(1));
                } else{ // = 0, no avatar or resume
                    userUpdate = userConverter.toUpdateDetail(userUpdateRequest, null, null);
                }
            }

            try{
                userMapper.updateUserDetail(userUpdate);
                FileUtils.deleteMultipleFilesToServer(request, uploadDir, avatarNameOld.concat(",").concat(resumeNameOld));
                return 1;
            } catch (Exception e){
                return 0;
            }
        }
        return 0;
    }
}
