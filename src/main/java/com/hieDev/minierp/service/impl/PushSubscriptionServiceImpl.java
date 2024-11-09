package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.converter.PushSubscriptionConverter;
import com.hieDev.minierp.security.Principal;
import com.hieDev.minierp.entity.PushSubscription;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.mapper.PushSubscriptionMapper;
import com.hieDev.minierp.model.request.subscribe.CreatePushSubscriptionRequest;
import com.hieDev.minierp.service.PushSubscriptionService;
import nl.martijndwars.webpush.Notification;
import nl.martijndwars.webpush.PushService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.util.List;

@Service
public class PushSubscriptionServiceImpl implements PushSubscriptionService {

    @Autowired
    PushSubscriptionMapper pushSubscriptionMapper;
    @Autowired
    PushSubscriptionConverter pushSubscriptionConverter;

    @Override
    public int createPushSubscription(CreatePushSubscriptionRequest createPushSubscriptionRequest){
        User user = Principal.getUserCurrent();
        createPushSubscriptionRequest.setUserId(user.getId());
        return pushSubscriptionMapper.createPushSubscription(pushSubscriptionConverter.toEntity(createPushSubscriptionRequest));
    }

    private PushService pushService;

    @Autowired
    public void PushNotificationService(@Value("${vapid.publicKey}") String vapidPublicKey,
                                        @Value("${vapid.privateKey}") String vapidPrivateKey,
                                        @Value("${vapid.subject}") String vapidMailto) throws GeneralSecurityException {
        this.pushService = new PushService(vapidPublicKey, vapidPrivateKey, vapidMailto);
    }

    @Override
    public void sendNotification(PushSubscription subscription, String payload) throws Exception {
        Notification notification = new Notification(
                subscription.getEndpoint(),
                subscription.getP256dh(),
                subscription.getAuth(),
                payload.getBytes(StandardCharsets.UTF_8)
        );
        pushService.send(notification);
    }

    @Override
    @Async
    public void sendNotificationAll(String payload, String userId){
        List<PushSubscription> allSubscriptions = pushSubscriptionMapper.findAll(userId);
        for (PushSubscription subscription : allSubscriptions) {
            try {
                sendNotification(subscription, payload);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public int deletePushSubscription(String endpoint) {
        return pushSubscriptionMapper.deletePushSubscription(endpoint);
    }

}
