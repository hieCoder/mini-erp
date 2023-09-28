package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.noti.NotificationConverter;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.mapper.NotificationMapper;
import com.shsoftvina.erpshsoftvina.model.request.NotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.NotificationResponse;
import com.shsoftvina.erpshsoftvina.service.NotificationService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificationImpl implements NotificationService {

    @Autowired
    NotificationMapper notificationMapper;

    @Autowired
    NotificationConverter notificationConverter;

    @Override
    public List<NotificationResponse> getAllNoti( int start, int pageSize) {
        List<Notification> notificationList = notificationMapper.getAllNoti(start, pageSize);
        return notificationConverter.toListResponse(notificationList);
    }

    @Override
    public NotificationResponse findById(String id) {
        return notificationConverter.toResponse(notificationMapper.findById(id));
    }

    @Override
    public void createNoti(NotificationRequest notificationRequest) {
        Notification notification = notificationConverter.toEntity(notificationRequest);
        notificationMapper.createNoti(notification);
    }

    @Override
    public boolean updateNoti(NotificationRequest notificationRequest, String id) {
        Notification notification = notificationConverter.toEntity(notificationRequest);
        notification.setId(id);
        return notificationMapper.updateNoti(notification);
    }

    @Override
    public boolean delNoti(String id) {
        return notificationMapper.delNoti(id);
    }
}
