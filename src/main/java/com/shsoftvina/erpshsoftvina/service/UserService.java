package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.user.UserCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;

import java.io.IOException;

public interface UserService {
    UserDetailResponse findUserDetailByEmail(String email);
    UserDetailResponse findUserDetailById(String id);
    UserDetailResponse findUserCheckRegister(String email, String username);
    void registerUser(UserCreateRequest user);
    int updateUser(UserUpdateRequest user) throws IOException;
}