package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.entity.PushSubscription;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.Notification.StatusNotificationEnum;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.subscribe.CreatePushSubscriptionRequest;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Component
public class PushSubscriptionConverter {
    @Autowired
    UserMapper userMapper;
    public PushSubscription toEntity(CreatePushSubscriptionRequest createPushSubscriptionRequest) {
        return PushSubscription.builder()
                .id(ApplicationUtils.generateId())
                .endpoint(createPushSubscriptionRequest.getEndpoint())
                .p256dh(createPushSubscriptionRequest.getP256dh())
                .auth(createPushSubscriptionRequest.getAuth())
                .user(userMapper.findById(createPushSubscriptionRequest.getUserId()))
                .build();
    }
}
