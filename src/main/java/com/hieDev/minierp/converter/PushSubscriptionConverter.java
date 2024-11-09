package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.PushSubscription;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.request.subscribe.CreatePushSubscriptionRequest;
import com.hieDev.minierp.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

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
