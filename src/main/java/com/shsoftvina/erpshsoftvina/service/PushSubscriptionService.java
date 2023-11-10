package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.entity.PushSubscription;
import com.shsoftvina.erpshsoftvina.model.request.subscribe.CreatePushSubscriptionRequest;

public interface PushSubscriptionService {
    int createPushSubscription(CreatePushSubscriptionRequest createPushSubscriptionRequest);
    void sendNotification(PushSubscription subscription, String payload) throws Exception;
    void sendNotificationAll(String payload, String userId);
    int deletePushSubscription(String endpoint);
}
