package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.UserCreateRequestDTO;
import com.shsoftvina.erpshsoftvina.model.response.UserDetailResponseDTO;
import com.shsoftvina.erpshsoftvina.model.response.UserResponse;

public interface UserService {
    UserDetailResponseDTO findUserDetail(String id);

    void disableUser(String id);

    void approveUserRegisterRequest(UserCreateRequestDTO user);
}