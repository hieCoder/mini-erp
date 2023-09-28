package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.exception.DuplicateException;
import com.shsoftvina.erpshsoftvina.exception.NoMatchException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.user.UserCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.ultis.FileUtils;
import com.shsoftvina.erpshsoftvina.ultis.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import com.shsoftvina.erpshsoftvina.constant.MailConstant;
import com.shsoftvina.erpshsoftvina.converter.user.UserConverter;
import com.shsoftvina.erpshsoftvina.model.request.DataMailDTO;
import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.ultis.SendMailUlti;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserConverter userConverter;
    @Autowired
    private SendMailUlti sendMailUlti;
    @Autowired
    private HttpServletRequest request;

//  The method returns the entire list of converted users
    @Override
    public List<UserDetailResponse> getAllUser(String searchTerm, String sortDirection, int start, int pageSize) {
//      List of all Users
        List<User> listUser = userMapper.getAllUser(searchTerm, sortDirection, start, pageSize);

//      Convert list User entity to List User UserResponse to return to user
        List<UserDetailResponse> mapperListUser = userConverter.toListResponse(listUser);

        return mapperListUser;
    }

    @Override
    public UserDetailResponse findUserDetail(String id) {
        User user = userMapper.findUserDetail(id);
        return userConverter.toResponse(user);
    }

    @Override
    public void disableUser(String id) {
        userMapper.changeStatusUser(id, (StatusUserEnum.DISABLE).toString());
    }

    @Override
    public Boolean activeUserRegisterRequest(UserActiveRequest userActiveRequest) {
        if (userActiveRequest.getStatus().equals(StatusUserEnum.REJECT)) {
            userMapper.deleteUser(userActiveRequest.getId());
            return true;
        } else {
            User user = userConverter.toEntity(userActiveRequest);
            userMapper.activeUserRegisterRequest(user);
            DataMailDTO dataMailDTO = new DataMailDTO();
            dataMailDTO.setTo(userActiveRequest.getEmail());
            dataMailDTO.setSubject(MailConstant.REGISTER_SUBJECT);
            dataMailDTO.setContent(MailConstant.REGISTER_CONTENT);
            return sendMailUlti.sendEmail(dataMailDTO);
        }
    }

    @Override
    public UserDetailResponse findUserCheckRegister(String email, String username){
        User user = userMapper.findUserCheckRegister(email,username);
        if(user == null) return null;
        return userConverter.toResponse(user);
    }

    @Override
    public int updateUser(UserUpdateRequest userUpdateRequest) {

        MultipartFile avatarFile = userUpdateRequest.getAvatar();
        MultipartFile contractFile = userUpdateRequest.getContract();

        String uploadDir = UserConstant.UPLOAD_FILE_DIR;

        boolean isSaveAvatar = true;
        boolean isSaveContract = true;

        String avatarDBValue = null;
        String contractDBValue = null;

        if(avatarFile != null){
            avatarDBValue = FileUtils.formatNameImage(avatarFile);
            isSaveAvatar = FileUtils.saveImageToServer(request, uploadDir, avatarFile, avatarDBValue);
        }
        if(contractFile != null){
            contractDBValue = FileUtils.formatNameImage(contractFile);
            isSaveContract = FileUtils.saveImageToServer(request, uploadDir, contractFile, contractDBValue);
        }

        if(isSaveAvatar && isSaveContract){

            User currentUserInDB = userMapper.findUserDetail(userUpdateRequest.getId());

            User user = userConverter.userUpdateRequestToEntity(userUpdateRequest);
            user.setAvatar(avatarDBValue);
            user.setContract(contractDBValue);
            int rs = userMapper.updateUser(user);
            if(rs == 0) {
                FileUtils.deleteImageFromServer(request, uploadDir, avatarDBValue);
                FileUtils.deleteImageFromServer(request, uploadDir, contractDBValue);
                return 0;
            }


            if(!StringUtils.isEmpty(currentUserInDB.getAvatar())){
                FileUtils.deleteImageFromServer(request, uploadDir, currentUserInDB.getAvatar());
            }
            if(!StringUtils.isEmpty(currentUserInDB.getContract())){
                FileUtils.deleteImageFromServer(request, uploadDir, currentUserInDB.getContract());
            }
            return 1;
        } else{
            return 0;
        }
    }

    @Override
    public int createUser(UserCreateRequest userCreateRequest){
        System.out.println(userCreateRequest);
        String username = userCreateRequest.getUsername();
        String email = userCreateRequest.getEmail();
        UserDetailResponse userDetailResponse = findUserCheckRegister(email,username);
        if(userDetailResponse == null){
            MultipartFile avatarFile = userCreateRequest.getAvatar();
            MultipartFile contractFile = userCreateRequest.getContract();

            String uploadDir = UserConstant.UPLOAD_FILE_DIR;

            boolean isSaveAvatar = true;
            boolean isSaveContract = true;

            String avatarDBValue = null;
            String contractDBValue = null;

            if(avatarFile != null){
                avatarDBValue = FileUtils.formatNameImage(avatarFile);
                isSaveAvatar = FileUtils.saveImageToServer(request, uploadDir, avatarFile, avatarDBValue);
            }
            if(contractFile != null){
                contractDBValue = FileUtils.formatNameImage(contractFile);
                isSaveContract = FileUtils.saveImageToServer(request, uploadDir, contractFile, contractDBValue);
            }

            if(isSaveAvatar && isSaveContract){
                User user = userConverter.userCreateRequestToEntity(userCreateRequest);
                user.setAvatar(avatarDBValue);
                user.setContract(contractDBValue);
                int rs = userMapper.createUser(user);
                if(rs == 0) {
                    FileUtils.deleteImageFromServer(request, uploadDir, avatarDBValue);
                    FileUtils.deleteImageFromServer(request, uploadDir, contractDBValue);
                    return 0;
                }
                return 1;
            } else {
                return 0;
            }
        }
        throw new DuplicateException("Username or email is exists");
    }
}