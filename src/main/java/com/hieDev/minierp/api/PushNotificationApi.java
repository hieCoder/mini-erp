package com.hieDev.minierp.api;

import com.hieDev.minierp.model.request.subscribe.CreatePushSubscriptionRequest;
import com.hieDev.minierp.service.PushSubscriptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/subscribe")
public class PushNotificationApi {
    @Autowired
    PushSubscriptionService pushSubscriptionService;

    @PostMapping()
    public ResponseEntity<?> subscribe(@RequestBody CreatePushSubscriptionRequest createPushSubscriptionRequest) {
        return ResponseEntity.ok(pushSubscriptionService.createPushSubscription(createPushSubscriptionRequest));
    }

    @DeleteMapping()
    public ResponseEntity<?> unsubscribe(@RequestBody CreatePushSubscriptionRequest createPushSubscriptionRequest) {
        return ResponseEntity.ok(pushSubscriptionService.deletePushSubscription(createPushSubscriptionRequest.getEndpoint()));
    }
}
