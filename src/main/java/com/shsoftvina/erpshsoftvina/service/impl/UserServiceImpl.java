package com.shsoftvina.erpshsoftvina.service.impl;

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
import com.shsoftvina.erpshsoftvina.model.response.users.ShowUserRespone;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;
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
    public UserDetailResponse findUserDetail(String id) {
        User s = null;
        try{
            s = userMapper.findById(id);
        } catch (Exception e){

        }
        return userConverter.toUserDetailResponse(s);
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
    public int updateUserDetail(UserUpdateRequest userUpdateRequest, String id) {
        User user = userMapper.findById(id);
        if(user == null) throw new NotFoundException(MessageErrorUtils.notFound("Id"));

        MultipartFile avatarFile = userUpdateRequest.getAvatar();
        MultipartFile resumeFile = userUpdateRequest.getResume();
        String avatarFileName = null;
        String resumeFileName = null;

        boolean isSaveSuccessAvatar = true;
        boolean isSaveSuccessResume = true;

        if(avatarFile != null){

            if(!FileUtils.isAllowedImageType(avatarFile, UserConstant.LIST_TYPE_IMAGE))
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowImageType());
            if(!FileUtils.isAllowedFileSize(avatarFile))
                throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize());

            String uploadDir = UserConstant.UPLOAD_FILE_DIR;
            avatarFileName = FileUtils.formatNameImage(avatarFile);
            isSaveSuccessAvatar = FileUtils.saveImageToServer(request, uploadDir, avatarFile, avatarFileName);
            user.setAvatar(avatarFileName);
        }
        if(resumeFile != null){

            if(!FileUtils.isAllowedImageType(resumeFile, UserConstant.LIST_TYPE_FILE))
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowImageType());
            if(!FileUtils.isAllowedFileSize(resumeFile))
                throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize());

            String uploadDir = UserConstant.UPLOAD_FILE_DIR;
            resumeFileName = FileUtils.formatNameImage(resumeFile);
            isSaveSuccessResume = FileUtils.saveImageToServer(request, uploadDir, resumeFile, resumeFileName);
            user.setResume(resumeFileName);
        }


        if(isSaveSuccessAvatar && isSaveSuccessResume){

            user = userConverter.userUpdateRequestToEntity(userUpdateRequest, avatarFileName, resumeFileName);
            try{
                userMapper.updateUserDetail(user);
                return 1;
            } catch (Exception e){
                return 0;
            }
        }
        return 0;
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
    public int createUserForAdmin(UserCreateAdminRequest userCreateAdminRequest) {

        if(!EnumUtils.isExistInEnum(RoleEnum.class, userCreateAdminRequest.getRole()))
            throw new NotFoundException(MessageErrorUtils.notFound("Role"));
        if (findByEmail(userCreateAdminRequest.getEmail()) != null)
            throw new DuplicateException("Email is exists");

        User user = userConverter.userCreateAdminRequestToEntity(userCreateAdminRequest);
        userMapper.createUserForAdmin(user);

        return 1;
    }

    @Override
    public int updateUserBasicProfile(UserUpdateProfileRequest userUpdateProfileRequest) {

        String id = userUpdateProfileRequest.getId();
        User user = userMapper.findById(id);
        if(user == null) throw new NotFoundException(MessageErrorUtils.notFound("Id"));

        MultipartFile avatarFile = userUpdateProfileRequest.getAvatar();
        MultipartFile resumeFile = userUpdateProfileRequest.getResume();
        String avatarFileName = null;
        String resumeFileName = null;
        boolean isSaveSuccessAvatar = true, isSaveSuccessResume = true;
        if(avatarFile != null){

            if(!FileUtils.isAllowedImageType(avatarFile, UserConstant.LIST_TYPE_IMAGE))
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowImageType());
            if(!FileUtils.isAllowedFileSize(avatarFile))
                throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize());

            String uploadDir = UserConstant.UPLOAD_FILE_DIR;
            avatarFileName = FileUtils.formatNameImage(avatarFile);
            isSaveSuccessAvatar = FileUtils.saveImageToServer(request, uploadDir, avatarFile, avatarFileName);
        }
        if(resumeFile != null){

            if(!FileUtils.isAllowedImageType(resumeFile, UserConstant.LIST_TYPE_FILE))
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowImageType());
            if(!FileUtils.isAllowedFileSize(resumeFile))
                throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize());

            String uploadDir = UserConstant.UPLOAD_FILE_DIR;
            resumeFileName = FileUtils.formatNameImage(resumeFile);
            isSaveSuccessAvatar = FileUtils.saveImageToServer(request, uploadDir, resumeFile, resumeFileName);
        }

        if(isSaveSuccessAvatar && isSaveSuccessResume){
            user = userConverter.toEntity(userUpdateProfileRequest, avatarFileName, resumeFileName);
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