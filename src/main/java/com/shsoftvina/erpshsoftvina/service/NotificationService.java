package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationShowResponse;

import java.util.List;

public interface NotificationService {
    List<NotificationShowResponse> getAllNoti(int start, int pageSize, String search);
    List<NotificationShowResponse> getInactiveNoti(int start, int pageSize);
    NotificationDetailResponse createNoti(CreateNotificationRequest createNotificationRequest);
    NotificationDetailResponse updateNotification(UpdateNotificationRequest updateNotificationRequest, String id);
    boolean delNoti(String id);
    NotificationDetailResponse findById(String id);
    int countAll(String search);
    List<NotificationShowResponse> getNotificationLatest(int limit);
}