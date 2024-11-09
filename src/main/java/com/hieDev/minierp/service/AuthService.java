package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.user.UserRegisterRequest;
import com.hieDev.minierp.entity.User;
import org.springframework.security.oauth2.core.user.OAuth2User;

public interface AuthService {
    int registerUser(UserRegisterRequest user);
    User registerUserOAuth2(OAuth2User oAuth2User);
}
