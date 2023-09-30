package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentsByNotificationIdResponse;
import com.shsoftvina.erpshsoftvina.service.CommentNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/comment")
public class CommentNotificationApi {
    @Autowired
    CommentNotificationService commentNotificationService;

    @PostMapping
    public ResponseEntity<?> commentNotification(@RequestBody CreateCommentRequest createCommentRequest){
        return ResponseEntity.ok(commentNotificationService.createCommentNotification(createCommentRequest));
    }

    @GetMapping("/{notificationId}")
    public ResponseEntity<CommentsByNotificationIdResponse> getCommentsByNotificationId(@PathVariable String notificationId) {
        CommentsByNotificationIdResponse comments = commentNotificationService.getCommentsByNotificationId(notificationId);
        return new ResponseEntity<>(comments, HttpStatus.OK);
    }


}
