package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;

public interface UserService {
    UserDetailResponse findUserDetail(String id);

    void disableUser(String id);

    Boolean activeUserRegisterRequest(UserActiveRequest user);
}