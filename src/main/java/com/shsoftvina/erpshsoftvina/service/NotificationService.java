package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationShowResponse;

import java.util.List;

public interface NotificationService {
    List<NotificationShowResponse> getAllNoti(int start, int pageSize);
    int createNoti(CreateNotificationRequest createNotificationRequest);
    int updateNoti(UpdateNotificationRequest updateNotificationRequest, String id);
    boolean delNoti(String id);
    NotificationDetailResponse findById(String id);
}