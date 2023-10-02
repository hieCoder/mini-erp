package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateProfileRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.ShowUserRespone;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;

import java.util.List;

public interface UserService {

    List<ShowUserRespone> getAllUser(String searchTerm,
                                     String sortDirection,
                                     int start,
                                     int pageSize,
                                     String status);

    UserDetailResponse findUserDetail(String id);

    void deleteUser(String id);

    Boolean activeUserRegisterRequest(UserActiveRequest user);

    UserDetailResponse findByEmail(String email);

    int updateUser(UserUpdateRequest userUpdateRequest);

    int createUser(UserCreateRequest user);

    int updateUserBasicProfile(UserUpdateProfileRequest user);
}