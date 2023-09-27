package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.user.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.response.UserResponse;
import com.shsoftvina.erpshsoftvina.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    @Autowired
    UserConverter userConverter;


//  The method returns the entire list of converted users
    @Override
    public List<UserResponse> getAllUser(String searchTerm, String sortDirection, int start, int pageSize) {
//      List of all Users
        List<User> listUser = userMapper.getAllUser(searchTerm, sortDirection, start, pageSize);

//      Convert list User entity to List User UserResponse to return to user
        List<UserResponse> mapperListUser = userConverter.toListResponse(listUser);

        return mapperListUser;
    }

//    Get User By Id
    @Override
    public UserResponse getUserById(String id) {
        User user = userMapper.getUserById(id);

        return userConverter.toResponse(user);
    }




}