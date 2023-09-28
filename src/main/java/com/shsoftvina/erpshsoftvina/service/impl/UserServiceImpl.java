package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.user.UserCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.ultis.FileUtils;
import com.shsoftvina.erpshsoftvina.ultis.IdGenerator;
import com.shsoftvina.erpshsoftvina.ultis.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserConverter userConverter;

    @Override
    public UserDetailResponse findUserDetailByEmail(String email) {
        return null;
    }

    @Autowired
    private HttpServletRequest request;

    @Override
    public UserDetailResponse findUserDetailById(String id){
        User user = userMapper.findUserDetailById(id);
        if(user == null) return null;
        return userConverter.ToUserDetailResponse(user);
    }

    @Override
    public UserDetailResponse findUserCheckRegister(String email, String username){
        User user = userMapper.findUserCheckRegister(email,username);
        if(user == null) return null;
        return userConverter.ToUserDetailResponse(user);
    }

    @Override
    public void registerUser(UserCreateRequest user){
        String username = user.getUsername();
        String email = user.getEmail();
        UserDetailResponse userDetailResponse = findUserCheckRegister(email,username);
        if(userDetailResponse == null){
            String generatorId = IdGenerator.newId();
            user.setId(generatorId);
            user.setStatus(StatusUserEnum.PENDING);
            // Process user registration, including role assignment
            PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            String rawPassword = user.getPassword();
            // Encode the user's password before storing it in the database
            String encodedPassword = passwordEncoder.encode(rawPassword);
            user.setPassword(encodedPassword);
            userMapper.registerUser(user);
        }

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

            User currentUserInDB = userMapper.findUserDetailById(userUpdateRequest.getId());

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
}