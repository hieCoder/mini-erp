package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentRequest;
import com.shsoftvina.erpshsoftvina.service.CommentNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/comment")
public class CommentNotificationApi {
    @Autowired
    CommentNotificationService commentNotificationService;

    @PostMapping
    public ResponseEntity<?> commentNotification(@RequestBody CreateCommentRequest createCommentRequest){
        return new ResponseEntity<>(commentNotificationService.createCommentNotification(createCommentRequest), HttpStatus.OK);
    }

    @PutMapping
    public ResponseEntity<?> updateComment(@RequestBody UpdateCommentRequest updateCommentRequest){
        return new ResponseEntity<>(commentNotificationService.updateCommentNotification(updateCommentRequest), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteComment(@PathVariable("id") String id){
        return new ResponseEntity<>(commentNotificationService.deleteCommentNotification(id), HttpStatus.OK);
    }

}
