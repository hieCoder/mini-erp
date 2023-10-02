package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationCommentsListResponse;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationResponse;
import com.shsoftvina.erpshsoftvina.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/v1/notifications")
public class NotificationApi {

    @Autowired
    NotificationService notificationService;

    //    Get all Notification
    @GetMapping
    public ResponseEntity<?> getAllNoti(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                        @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize) {

        List<NotificationResponse> notificationResponseList =
                notificationService.getAllNoti((page - 1) * pageSize, pageSize);

        return new ResponseEntity<>(notificationResponseList, HttpStatus.OK);
    }

    //    Create New Notification
    @PostMapping
    public ResponseEntity<?> createNoti(@Valid CreateNotificationRequest createNotificationRequest) {
        return ResponseEntity.ok(notificationService.createNoti(createNotificationRequest));
    }

    //    Update Notification
    @PostMapping("/{id}")
    public ResponseEntity<?> updateNoti(@Valid UpdateNotificationRequest updateNotificationRequest,
                                        @PathVariable("id") String id) {
        return ResponseEntity.ok(notificationService.updateNoti(updateNotificationRequest, id));
    }

    //    Delete Notification
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delNoti(@PathVariable("id") String id) {
        return ResponseEntity.ok(notificationService.delNoti(id));
    }

    @GetMapping("/{notificationId}")
    public ResponseEntity<?> notificationDetail(@PathVariable String notificationId) {
        NotificationCommentsListResponse comments = notificationService.getCommentsByNotificationId(notificationId);
        return new ResponseEntity<>(comments, HttpStatus.OK);
    }
}
