package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.NotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.NotificationResponse;
import com.shsoftvina.erpshsoftvina.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/notifications")
public class NotiApi {

    @Autowired
    NotificationService notificationService;

    //    Get all Notification
    @GetMapping
    public ResponseEntity<?> getAllNoti(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                        @RequestParam(name = "pageSize", required = false, defaultValue = "5") int pageSize) {

        List<NotificationResponse> notificationResponseList = notificationService.getAllNoti((page - 1) * pageSize, pageSize);
        return new ResponseEntity<>(notificationResponseList, HttpStatus.OK);
    }

    //    Create New Notification
    @PostMapping
    public ResponseEntity<?> createNoti(@RequestBody NotificationRequest notificationRequest) {

        notificationService.createNoti(notificationRequest);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    //    Update Notification
    @PutMapping("/{id}")
    public ResponseEntity<?> updateNoti(@RequestBody NotificationRequest notificationRequest,
                                        @PathVariable("id") String id) {

        boolean isUpdateSuccess = notificationService.updateNoti(notificationRequest, id);
        if (isUpdateSuccess) return ResponseEntity.ok(isUpdateSuccess);
        return new ResponseEntity<>(isUpdateSuccess, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    //    Delete Notification
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delNoti(@PathVariable("id") String id) {

        boolean isDelSuccess = notificationService.delNoti(id);
        if(isDelSuccess) return ResponseEntity.ok(isDelSuccess);
        return new ResponseEntity<>(isDelSuccess, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
