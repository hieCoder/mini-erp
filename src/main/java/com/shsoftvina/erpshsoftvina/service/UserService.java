package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;

import java.util.List;


public interface UserService {

    List<UserDetailResponse> getAllUser(String searchTerm, String sortDirection, int start, int pageSize); // Get All User

    UserDetailResponse findUserDetail(String id);

    void disableUser(String id);

    Boolean activeUserRegisterRequest(UserActiveRequest user);

    UserDetailResponse findUserCheckRegister(String email, String username);

    int updateUser(UserUpdateRequest user);

    int createUser(UserCreateRequest user);
}