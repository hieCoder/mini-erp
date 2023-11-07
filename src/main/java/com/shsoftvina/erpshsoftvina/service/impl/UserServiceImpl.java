package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.MailConstant;
import com.shsoftvina.erpshsoftvina.constant.SettingConstant;
import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.Setting;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.exception.*;
import com.shsoftvina.erpshsoftvina.mapper.SettingMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.dto.DataMailDto;
import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.PageUserListRespone;
import com.shsoftvina.erpshsoftvina.model.response.user.IdAndFullnameUserResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.UserShowResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.utils.*;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

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

    @Autowired
    private ApplicationUtils applicationUtils;

    @Autowired
    private SettingMapper settingMapper;

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

        applicationUtils.checkUserAllow(id);

        User user = null;
        try {
            user = userMapper.findById(id);
            if (Principal.getUserCurrent().getRole() == null)
                throw new UnauthorizedException(MessageErrorUtils.unknown("Role"));
        } catch (Exception e) {
        }
        return userConverter.toUserDetailResponse(user);
    }

    @Override
    public IdAndFullnameUserResponse findIdAndFullNameOfUser(String id) {
        return userConverter.toIdAndFullnameUserResponse(userMapper.findById(id));
    }

    @Override
    public int deleteUser(String id) {
        return userMapper.changeStatusUser(id, (StatusUserEnum.INACTIVE).toString());
    }

    @Override
    public Boolean activeUserRegisterRequest(UserActiveRequest userActiveRequest) {

        if (userActiveRequest.getStatus().equals(StatusUserEnum.ACTIVE)) {
            if (!EnumUtils.isExistInEnum(RoleEnum.class, userActiveRequest.getRole()))
                throw new NotFoundException(MessageErrorUtils.notFound("Role"));
        }

        if (!EnumUtils.isExistInEnum(StatusUserEnum.class, userActiveRequest.getStatus()))
            throw new NotFoundException(MessageErrorUtils.notFound("Status"));

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

    @Override
    public Boolean rejectUserRegisterRequest(String id) {

        User user = userMapper.findById(id);
        if (user == null) throw new NotFoundException(MessageErrorUtils.notFound("Id"));

        try {
            userMapper.deleteUser(id);
            return true;
        } catch (Exception e) {
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

        User user = userMapper.findById(userUpdateRequest.getId());
        if (user == null) throw new NotFoundException(MessageErrorUtils.notFound("Id"));

        MultipartFile avatarFile = userUpdateRequest.getAvatar();
        String remainResumeFiles = userUpdateRequest.getRemainResumeFiles();
        MultipartFile[] newResumeFiles = userUpdateRequest.getNewResumeFiles();

        String uploadDir = UserConstant.UPLOAD_FILE_DIR;
        String newAvatarName = null;
        List<String> newResumeFileNameList = new ArrayList<>();

        if (avatarFile != null) {
            applicationUtils.checkValidateImage(User.class, avatarFile);
            newAvatarName = FileUtils.formatNameImage(avatarFile);
            if (!FileUtils.saveImageToServer(request, uploadDir, avatarFile, newAvatarName)) return 0;
        }
        if (newResumeFiles != null) {

            Setting setting = settingMapper.findByCode(SettingConstant.USER_CODE);
            if (!FileUtils.isAllowedFileSize(newResumeFiles, setting.getFileSize()))
                throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize(setting.getFileSize()));
            if (!FileUtils.isAllowedFileType(newResumeFiles, setting.getFileType()))
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType(setting.getFileType()));

            newResumeFileNameList = FileUtils.saveMultipleFilesToServer(request, uploadDir, newResumeFiles);
            if (newResumeFileNameList == null) {
                if (newAvatarName != null) FileUtils.deleteImageFromServer(request, uploadDir, newAvatarName);
                return 0;
            }
        }

        String newAvatarFileToDB = avatarFile != null ? newAvatarName : user.getAvatar();
        String newResumeFilesToDB = null;
        if (StringUtils.isBlank(remainResumeFiles)) {
            newResumeFilesToDB = String.join(",", newResumeFileNameList);
        } else {
            if (!newResumeFileNameList.isEmpty()) {
                newResumeFilesToDB = remainResumeFiles + "," + String.join(",", newResumeFileNameList);
            } else newResumeFilesToDB = remainResumeFiles;
        }

        User userUpdate = null;
        if (Principal.getUserCurrent().getRole().equals(RoleEnum.DEVELOPER)) {
            userUpdate = userConverter.toUpdateBasic(userUpdateRequest, newAvatarFileToDB, newResumeFilesToDB);
        } else {
            userUpdate = userConverter.toUpdateDetail(userUpdateRequest, newAvatarFileToDB, newResumeFilesToDB);
        }

        String avatarNameOld = user.getAvatar();
        String resumeNameOld = user.getResume();
        String avatarNameNew = userUpdate.getAvatar();
        String resumeNameNew = userUpdate.getResume();
        try {
            if (Principal.getUserCurrent().getRole().equals(RoleEnum.DEVELOPER)) {
                userMapper.updateUserProfile(userUpdate);
            } else {
                userMapper.updateUserDetail(userUpdate);
            }

            if (!avatarNameOld.equals(avatarNameNew) && !avatarNameOld.equals(UserConstant.AVATAR_DEFAULT)) {
                FileUtils.deleteImageFromServer(request, uploadDir, avatarNameOld);
            }
            if (!resumeNameOld.equals(resumeNameNew)) {
                String deleteFiles = StringUtils.getDifference(resumeNameOld, remainResumeFiles);
                FileUtils.deleteMultipleFilesToServer(request, uploadDir, deleteFiles);
            }

            return 1;
        } catch (Exception e) {
            return 0;
        }
    }

    @Override
    public List<Map<String, Object>> getAllFullname() {
        List<Map<String, Object>> maps = userMapper.getAllFullname();
        updateValueInList(maps, "avatar");
        return maps;
    }

    public void updateValueInList(List<Map<String, Object>> maps, String oldKey) {
        for (Map<String, Object> map : maps) {
            if (map.containsKey(oldKey)) {
                Object oldValue = map.get(oldKey);
                String newValue = FileUtils.getPathUpload(User.class, oldValue.toString());
                map.put(oldKey, newValue);
            }
        }
    }
}
