package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.exception.DuplicateException;
import com.shsoftvina.erpshsoftvina.exception.NoMatchException;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.service.AuthService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
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
