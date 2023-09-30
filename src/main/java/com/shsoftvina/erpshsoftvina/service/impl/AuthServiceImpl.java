package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.user.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.exception.DuplicateException;
import com.shsoftvina.erpshsoftvina.exception.NoMatchException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.service.AuthService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    UserService userService;

    @Autowired
    UserConverter userConverter;

    @Autowired
    UserMapper userMapper;

    @Override
    public int registerUser(UserRegisterRequest userRegisterRequest){
        String pass = userRegisterRequest.getPassword();
        String passConfirm = userRegisterRequest.getConfirmPassword();
        if(!passConfirm.equals(pass)){
            throw new NoMatchException("Password no match");
        }

        String email = userRegisterRequest.getEmail();
        UserDetailResponse userDetailResponse = userService.findUserCheckRegister(email);
        if(userDetailResponse == null){
            User user = userConverter.userRegisterRequestToEntity(userRegisterRequest);
            return userMapper.registerUser(user);
        }
        throw new DuplicateException("Username or email is exists");
    }
}
