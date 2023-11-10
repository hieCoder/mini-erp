package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import org.springframework.security.oauth2.core.user.OAuth2User;

public interface AuthService {
    int registerUser(UserRegisterRequest user);
    User registerUserOAuth2(OAuth2User oAuth2User);
}
