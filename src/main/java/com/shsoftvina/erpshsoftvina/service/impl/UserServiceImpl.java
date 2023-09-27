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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
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
            userMapper.declineUserRegisterRequest(userActiveRequest.getId());
            return true;
        } else {
            User user = userConverter.toEntity(userActiveRequest);
            userMapper.activeUserRegisterRequest(user);
            return sendEmail(userActiveRequest);
        }
    }

    public Boolean sendEmail(UserActiveRequest userActiveRequest) {
        try {
            DataMail dataMail = new DataMail();
            dataMail.setTo(userActiveRequest.getEmail());
            dataMail.setSubject(MailConstant.REGISTER_SUBJECT);
            dataMail.setContent("Your account have been registered!!!");
            mailService.sendMail(dataMail);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return false;
    }
}