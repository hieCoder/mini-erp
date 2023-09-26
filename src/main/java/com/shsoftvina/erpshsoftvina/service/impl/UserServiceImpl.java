package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.UserCreateRequestDTO;
import com.shsoftvina.erpshsoftvina.model.response.UserDetailResponseDTO;
import com.shsoftvina.erpshsoftvina.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserConverter userConverter;
    @Override
    public UserDetailResponseDTO findUserDetail(String id) {
        User user = userMapper.findUserDetail(id);
        return userConverter.convertEntityToDetailResponse(user);
    }

    @Override
    public void disableUser(String id) {
        userMapper.disableUser(id);
    }

    @Override
    public void approveUserRegisterRequest(UserCreateRequestDTO userCreateRequestDTO) {
        User user = userConverter.convertCreateRequestToEntity(userCreateRequestDTO);
        userMapper.approveUserRegisterRequest(user);
    }
}