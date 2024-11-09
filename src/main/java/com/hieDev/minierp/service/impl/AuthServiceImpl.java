package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.converter.UserConverter;
import com.hieDev.minierp.exception.DuplicateException;
import com.hieDev.minierp.exception.NoMatchException;
import com.hieDev.minierp.exception.NotFoundException;
import com.hieDev.minierp.model.request.user.UserRegisterRequest;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.service.AuthService;
import com.hieDev.minierp.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService {

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
        User user = userMapper.findByEmail(email);

        if(user != null) throw new DuplicateException("UserID is existed in the system");

        user = userConverter.toEntity(userRegisterRequest);
        return userMapper.registerUser(user);
    }

    @Override
    public User registerUserOAuth2(OAuth2User oAuth2User) {

        String email = (String) oAuth2User.getAttributes().get("email");
        if(email == null) throw new NotFoundException(MessageErrorUtils.notFound("email"));

        User user = userConverter.toEntity(oAuth2User);
        try{
            userMapper.registerUser(user);
            return user;
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
