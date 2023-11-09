package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationShowResponse;
import com.shsoftvina.erpshsoftvina.service.NotificationService;
import com.shsoftvina.erpshsoftvina.service.PushSubscriptionService;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/notifications")
public class NotificationApi {

    @Autowired
    NotificationService notificationService;

    @Autowired
    PushSubscriptionService pushSubscriptionService;

    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

    //    Get all Notification
    @GetMapping
    public ResponseEntity<?> getAllNoti(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                        @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize,
                                         @RequestParam(name = "search", required = false, defaultValue = "") String search
    ) {

        return ResponseEntity.ok(notificationService.getAllNoti((page - 1) * pageSize, pageSize, search));
    }

    @GetMapping("/inactive")
    public ResponseEntity<?> getInactiveNoti(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                        @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize
    ) {
        return ResponseEntity.ok(notificationService.getInactiveNoti((page - 1) * pageSize, pageSize));
    }

    //    Create New Notification
    @MessageMapping("/createNotification")
    @SendTo("/notification/createNotification")
    @PostMapping
    public ResponseEntity<?> createNoti(@Valid CreateNotificationRequest createNotificationRequest) {
        NotificationDetailResponse rs = notificationService.createNoti(createNotificationRequest);
        rs.setCategoryPush("Notifications");
        if(rs != null) {
            pushSubscriptionService.sendNotificationAll(JsonUtils.objectToJson(rs));
        }
        return ResponseEntity.ok(rs);
    }

    //    Update Notification
    @PostMapping("/update/{id}")
    public ResponseEntity<?> updateNotification(@Valid UpdateNotificationRequest updateNotificationRequest,
                                                @PathVariable("id") String id) {
        return ResponseEntity.ok(notificationService.updateNotification(updateNotificationRequest, id));
    }

    //    Delete Notification
    @MessageMapping("/deleteNotification")
    @SendTo("/notification/deleteNotification")
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delNoti(@PathVariable("id") String id) {
        boolean rs = notificationService.delNoti(id);
        if(rs) simpMessagingTemplate.convertAndSend("/notification/deleteNotification", id);
        return ResponseEntity.ok(rs);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> notificationDetail(@PathVariable String id) {
        return ResponseEntity.ok(notificationService.findById(id));
    }
}
