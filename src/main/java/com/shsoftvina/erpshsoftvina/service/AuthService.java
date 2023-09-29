package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;

public interface AuthService {
    int registerUser(UserRegisterRequest user);
}
