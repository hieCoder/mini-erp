package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.NotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.NotificationResponse;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NotificationService {
    List<NotificationResponse> getAllNoti(int start, int pageSize);
    NotificationResponse findById(String id);
    void createNoti(NotificationRequest notificationRequest);
    boolean updateNoti(NotificationRequest notificationRequest, String id);
    boolean delNoti(String id);
}
