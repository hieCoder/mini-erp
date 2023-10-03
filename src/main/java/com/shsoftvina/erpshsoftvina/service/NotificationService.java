package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationCommentsListResponse;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationResponse;

import java.util.List;

public interface NotificationService {
    List<NotificationResponse> getAllNoti(int start, int pageSize);
    int createNoti(CreateNotificationRequest createNotificationRequest);
    int updateNoti(UpdateNotificationRequest updateNotificationRequest, String id);
    boolean delNoti(String id);
    NotificationCommentsListResponse findById(String id);
}
