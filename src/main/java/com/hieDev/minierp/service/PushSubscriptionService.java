package com.hieDev.minierp.service;

import com.hieDev.minierp.entity.PushSubscription;
import com.hieDev.minierp.model.request.subscribe.CreatePushSubscriptionRequest;

public interface PushSubscriptionService {
    int createPushSubscription(CreatePushSubscriptionRequest createPushSubscriptionRequest);
    void sendNotification(PushSubscription subscription, String payload) throws Exception;
    void sendNotificationAll(String payload, String userId);
    int deletePushSubscription(String endpoint);
}
