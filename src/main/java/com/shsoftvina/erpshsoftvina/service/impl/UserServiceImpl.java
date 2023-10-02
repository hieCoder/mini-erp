package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.constant.MailConstant;
import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.exception.*;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.dto.DataMailDto;
import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateProfileRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.BasicUserDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.users.ShowUserRespone;
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
    public List<ShowUserRespone> getAllUser(String searchTerm,
                                            String sortDirection,
                                            int start,
                                            int pageSize,
                                            String status) {
        List<User> listUser = userMapper.getAllUser(searchTerm, sortDirection, start, pageSize, status);
        return userConverter.toListShowUserRespone(listUser);
    }

    @Override
    public BasicUserDetailResponse findUserDetail(String id) {
        User user = userMapper.findById(id);

        User userCurrent = Principal.getUserCurrent();
        if(!user.getRole().equals(userCurrent.getRole())
                && userCurrent.getRole().equals(RoleEnum.DEVELOPER))
            throw new UnauthorizedException(MessageErrorUtils.unauthorized());

        RoleEnum userCurrentRole = Principal.getUserCurrent().getRole();
        if(userCurrentRole.equals(RoleEnum.DEVELOPER)){
            return userConverter.toBasicUserDetailResponse(user);
        }
        return userConverter.toUserDetailResponse(user);
    }

    @Override
    public void deleteUser(String id) {
        userMapper.changeStatusUser(id, (StatusUserEnum.INACTIVE).toString());
    }

    @Override
    public Boolean activeUserRegisterRequest(UserActiveRequest userActiveRequest) {

        if(!EnumUtils.isExistInEnum(RoleEnum.class, userActiveRequest.getRole()))
            throw new NotFoundException(MessageErrorUtils.notFound("Role"));
        if(!EnumUtils.isExistInEnum(StatusUserEnum.class, userActiveRequest.getStatus()))
            throw new NotFoundException(MessageErrorUtils.notFound("Status"));

        if (userActiveRequest.getStatus().equals(StatusUserEnum.REJECT)) {
            try{
                userMapper.deleteUser(userActiveRequest.getId());
                return true;
            } catch (Exception e){
                return false;
            }
        } else {
            User user = userConverter.toEntity(userActiveRequest);

            try{
                userMapper.activeUserRegister(user);

                DataMailDto dataMailDto = new DataMailDto();
                dataMailDto.setTo(userActiveRequest.getEmail());
                dataMailDto.setSubject(MailConstant.REGISTER_SUBJECT);
                dataMailDto.setContent(MailConstant.REGISTER_CONTENT);
                return sendMailUtils.sendEmail(dataMailDto);
            } catch (Exception e){ }
            return false;
        }
    }

    @Override
    public UserDetailResponse findByEmail(String email){
        User user = userMapper.findByEmail(email);
        if(user == null) return null;
        return userConverter.toUserDetailResponse(user);
    }

    @Override
    public int updateUser(UserUpdateRequest userUpdateRequest) {
//
//        if (userUpdateRequest.getContract().length > NotificationConstant.NUMBER_FILE_LIMIT) {
//            throw new FileTooLimitedException("Max file is 3");
//        }
//        MultipartFile avatarFile = userUpdateRequest.getAvatar();
//        MultipartFile[] contractFile = userUpdateRequest.getContract();
//
//        String uploadDir = UserConstant.UPLOAD_FILE_DIR;
//
//        boolean isSaveAvatar = true;
//        boolean isSaveContract = true;
//
//        String avatarDBValue = null;
//        String contractDBValue = null;
//
//        if(avatarFile != null){
//            avatarDBValue = FileUtils.formatNameImage(avatarFile);
//            isSaveAvatar = FileUtils.saveImageToServer(request, uploadDir, avatarFile, avatarDBValue);
//        }
//        if(contractFile != null){
//            contractDBValue = FileUtils.formatNameImage(contractFile);
//            isSaveContract = FileUtils.saveImageToServer(request, uploadDir, contractFile, contractDBValue);
//        }
//
//        if(isSaveAvatar && isSaveContract){
//
//            User currentUserInDB = userMapper.findUserDetail(userUpdateRequest.getId());
//
//            User user = userConverter.userUpdateRequestToEntity(userUpdateRequest);
//            user.setAvatar(avatarDBValue);
//            user.setContract(contractDBValue);
//            int rs = userMapper.updateUser(user);
//            if(rs == 0) {
//                FileUtils.deleteImageFromServer(request, uploadDir, avatarDBValue);
//                FileUtils.deleteImageFromServer(request, uploadDir, contractDBValue);
//                return 0;
//            }
//
//
//            if(!StringUtils.isEmpty(currentUserInDB.getAvatar())){
//                FileUtils.deleteImageFromServer(request, uploadDir, currentUserInDB.getAvatar());
//            }
//            if(!StringUtils.isEmpty(currentUserInDB.getContract())){
//                FileUtils.deleteImageFromServer(request, uploadDir, currentUserInDB.getContract());
//            }
//            return 1;
//        } else{
//            return 0;
//        }
        return 1;
    }

    @Override
    public int createUser(UserCreateRequest userCreateRequest){
//        String email = userCreateRequest.getEmail();
//        UserDetailResponse userDetailResponse = findUserCheckRegister(email);
//        if(userDetailResponse == null){
//            MultipartFile avatarFile = userCreateRequest.getAvatar();
//            MultipartFile contractFile = userCreateRequest.getContract();
//
//            String uploadDir = UserConstant.UPLOAD_FILE_DIR;
//
//            boolean isSaveAvatar = true;
//            boolean isSaveContract = true;
//
//            String avatarDBValue = null;
//            String contractDBValue = null;
//
//            if(avatarFile != null){
//                avatarDBValue = FileUtils.formatNameImage(avatarFile);
//                isSaveAvatar = FileUtils.saveImageToServer(request, uploadDir, avatarFile, avatarDBValue);
//            }
//            if(contractFile != null){
//                contractDBValue = FileUtils.formatNameImage(contractFile);
//                isSaveContract = FileUtils.saveImageToServer(request, uploadDir, contractFile, contractDBValue);
//            }
//
//            if(isSaveAvatar && isSaveContract){
//                User user = userConverter.userCreateRequestToEntity(userCreateRequest);
//                user.setAvatar(avatarDBValue);
//                user.setContract(contractDBValue);
//                int rs = userMapper.createUser(user);
//                if(rs == 0) {
//                    FileUtils.deleteImageFromServer(request, uploadDir, avatarDBValue);
//                    FileUtils.deleteImageFromServer(request, uploadDir, contractDBValue);
//                    return 0;
//                }
//                return 1;
//            } else {
//                return 0;
//            }
//        }
//        throw new DuplicateException("Username or email is exists");
        return 0;
    }

    @Override
    public int updateUserBasicProfile(UserUpdateProfileRequest userUpdateProfileRequest) {

        String id = userUpdateProfileRequest.getId();
        User user = userMapper.findById(id);
        if(user == null) throw new NotFoundException(MessageErrorUtils.notFound("Id"));

        MultipartFile avatarFile = userUpdateProfileRequest.getAvatar();
        String fileName = null;
        boolean isSaveSuccess = true;
        if(avatarFile != null){

            if(!FileUtils.isAllowedImageType(avatarFile, UserConstant.LIST_TYPE_IMAGE))
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowImageType());
            if(!FileUtils.isAllowedFileSize(avatarFile))
                throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize());

            String uploadDir = UserConstant.UPLOAD_FILE_DIR;
            fileName = FileUtils.formatNameImage(avatarFile);
            isSaveSuccess = FileUtils.saveImageToServer(request, uploadDir, avatarFile, fileName);
        }

        if(isSaveSuccess){
            user = userConverter.toEntity(userUpdateProfileRequest, fileName);
            try{
                userMapper.updateUserProfile(user);
                return 1;
            } catch (Exception e){
                return 0;
            }
        }
        return 0;
    }
}