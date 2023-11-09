package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.PushSubscriptionConverter;
import com.shsoftvina.erpshsoftvina.entity.PushSubscription;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.PushSubscriptionMapper;
import com.shsoftvina.erpshsoftvina.model.request.subscribe.CreatePushSubscriptionRequest;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.PushSubscriptionService;
import nl.martijndwars.webpush.Notification;
import nl.martijndwars.webpush.PushService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
    public void sendNotificationAll(String payload){
        User user = Principal.getUserCurrent();
        List<PushSubscription> allSubscriptions = pushSubscriptionMapper.findAll(user.getId());
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
