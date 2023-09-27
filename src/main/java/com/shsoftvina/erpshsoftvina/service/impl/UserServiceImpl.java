package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.MailConstant;
import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.StatusEnum;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.DataMail;
import com.shsoftvina.erpshsoftvina.model.request.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.response.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.service.MailService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.ultis.SendMailUlti;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserConverter userConverter;
    @Autowired
    private MailService mailService;
    @Autowired
    private SendMailUlti sendMailUlti;

    @Override
    public UserDetailResponse findUserDetail(String id) {
        User user = userMapper.findUserDetail(id);
        return userConverter.convertEntityToDetailResponse(user);
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
            DataMail dataMail = new DataMail();
            dataMail.setTo(userActiveRequest.getEmail());
            dataMail.setSubject(MailConstant.REGISTER_SUBJECT);
            dataMail.setContent(MailConstant.REGISTER_CONTENT);
            return sendMailUlti.sendEmail(dataMail);
        }
    }
}