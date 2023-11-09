package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.entity.PushSubscription;
import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.subscribe.CreatePushSubscriptionRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationDetailResponse;

public interface PushSubscriptionService {
    int createPushSubscription(CreatePushSubscriptionRequest createPushSubscriptionRequest);
    void sendNotification(PushSubscription subscription, String payload) throws Exception;
    void sendNotificationAll(String payload);
    int deletePushSubscription(String endpoint);
}
