package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.MailConstant;
import com.shsoftvina.erpshsoftvina.converter.user.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.StatusEnum;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.DataMailDTO;
import com.shsoftvina.erpshsoftvina.model.request.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.ultis.SendMailUlti;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserConverter userConverter;
    @Autowired
    private SendMailUlti sendMailUlti;

    @Override
    public UserDetailResponse findUserDetail(String id) {
        User user = userMapper.findUserDetail(id);
        return userConverter.toResponse(user);
    }

    @Override
    public void disableUser(String id) {
        userMapper.changeStatusUser(id, (StatusEnum.DISABLE).toString());
    }

    @Override
    public Boolean activeUserRegisterRequest(UserActiveRequest userActiveRequest) {
        if (userActiveRequest.getStatus().equals(StatusEnum.REJECT)) {
            userMapper.deleteUser(userActiveRequest.getId());
            return true;
        } else {
            User user = userConverter.toEntity(userActiveRequest);
            userMapper.activeUserRegisterRequest(user);
            DataMailDTO dataMailDTO = new DataMailDTO();
            dataMailDTO.setTo(userActiveRequest.getEmail());
            dataMailDTO.setSubject(MailConstant.REGISTER_SUBJECT);
            dataMailDTO.setContent(MailConstant.REGISTER_CONTENT);
            return sendMailUlti.sendEmail(dataMailDTO);
        }
    }



//  The method returns the entire list of converted users
    @Override
    public List<UserDetailResponse> getAllUser(String searchTerm, String sortDirection, int start, int pageSize) {
//      List of all Users
        List<User> listUser = userMapper.getAllUser(searchTerm, sortDirection, start, pageSize);

//      Convert list User entity to List User UserResponse to return to user
        List<UserDetailResponse> mapperListUser = userConverter.toListResponse(listUser);

        return mapperListUser;
    }

}