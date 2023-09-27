package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;

import java.util.List;

public interface UserService {
    UserDetailResponse findUserDetail(String id);

    void disableUser(String id);

    Boolean activeUserRegisterRequest(UserActiveRequest user);

    List<UserDetailResponse> getAllUser(String searchTerm, String sortDirection, int start, int pageSize); // Get All User
}