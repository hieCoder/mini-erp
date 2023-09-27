package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.response.UserResponse;

import java.util.List;

public interface UserService {
    List<UserResponse> getAllUser(String searchTerm, String sortDirection, int start, int pageSize); // Get All User
    UserResponse getUserById(String id); // get User By Id
}