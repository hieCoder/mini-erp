package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.exception.DuplicateException;
import com.shsoftvina.erpshsoftvina.exception.NoMatchException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
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
        if(pass!= null && passConfirm!= null && !passConfirm.equals(pass)){
            throw new NoMatchException("Password confirm isn't matched");
        }

        String email = userRegisterRequest.getEmail();
        UserDetailResponse userDetailResponse = userService.findByEmail(email);

        if(userDetailResponse != null) throw new DuplicateException("UserID is existed in the system");

        User user = userConverter.toEntity(userRegisterRequest);
        return userMapper.registerUser(user);

    }
}
