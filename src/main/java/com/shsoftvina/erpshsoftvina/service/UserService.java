package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.user.*;
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

    int updateUserDetail(UserUpdateRequest userUpdateRequest, String id);

    int createUser(UserCreateRequest userCreateRequest);

    int createUserForAdmin(UserCreateAdminRequest userCreateAdminRequest);

    int updateUserBasicProfile(UserUpdateProfileRequest user);
}