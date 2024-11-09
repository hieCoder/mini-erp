package com.hieDev.minierp.service;


import com.hieDev.minierp.model.request.user.UserActiveRequest;
import com.hieDev.minierp.model.request.user.UserUpdateRequest;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.model.response.user.IdAndFullnameUserResponse;
import com.hieDev.minierp.model.response.user.PageUserListRespone;
import com.hieDev.minierp.model.response.user.UserDetailResponse;

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

    List<User> findUserBirthdayToday();
}
