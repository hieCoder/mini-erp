package com.shsoftvina.erpshsoftvina.service;


import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.PageUserListRespone;
import com.shsoftvina.erpshsoftvina.model.response.user.IdAndFullnameUserResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;

import java.util.List;
import java.util.Map;

public interface UserService {

    PageUserListRespone getAllUser(String searchTerm,
                                   String sortDirection,
                                   int start,
                                   int pageSize,
                                   String status);

    UserDetailResponse findUserDetail(String id);
    IdAndFullnameUserResponse findIdAndFullNameOfUser(String id);

    int deleteUser(String id);

    Boolean activeUserRegisterRequest(UserActiveRequest user);

    Boolean rejectUserRegisterRequest(String id);

    UserDetailResponse findByEmail(String email);

    int updateUserDetail(UserUpdateRequest userUpdateRequest);

    List<Map<String, Object>> getAllFullname();

}
