package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.request.user.*;
import com.shsoftvina.erpshsoftvina.model.response.users.BasicUserDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.users.ShowUserRespone;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserService {

    List<ShowUserRespone> getAllUser(String searchTerm,
                                     String sortDirection,
                                     int start,
                                     int pageSize,
                                     String status);

    BasicUserDetailResponse findUserDetail(String id);

    void deleteUser(String id);

    Boolean activeUserRegisterRequest(UserActiveRequest user);

    UserDetailResponse findByEmail(String email);

    User findById(String id);

    int updateUserForAdmin(UserUpdateRequest userUpdateRequest, String id);

    int createUser(UserCreateRequest userCreateRequest);

    int createUserForAdmin(UserCreateAdminRequest userCreateAdminRequest);

    int updateUserBasicProfile(UserUpdateProfileRequest user);
}