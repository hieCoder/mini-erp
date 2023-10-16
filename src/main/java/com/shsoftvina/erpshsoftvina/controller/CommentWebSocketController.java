package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentNotificationResponse;
import com.shsoftvina.erpshsoftvina.service.CommentNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;

@Controller
public class CommentWebSocketController {
    @Autowired
    CommentNotificationService commentNotificationService;

    @MessageMapping("/comment")
    @SendTo("/notification/comments")
    public CommentNotificationResponse handleComment(@Valid @RequestBody CreateCommentNotificationRequest createCommentNotificationRequest) {
        CommentNotificationResponse commentNotificationResponse = commentNotificationService.createCommentNotification(createCommentNotificationRequest);
        return commentNotificationResponse;
    }

    @MessageMapping("/editcomment")
    @SendTo("/notification/editcomments")
    public CommentNotificationResponse handleEditComment(@RequestBody CreateCommentNotificationRequest createCommentNotificationRequest) {
        System.out.println("createCommentNotificationRequest edit");
        return new CommentNotificationResponse();
    }

    @MessageMapping("/deletecomment")
    @SendTo("/notification/deletecomments")
    public CommentNotificationResponse handleDeleteComment(@RequestBody CreateCommentNotificationRequest createCommentNotificationRequest) {
        System.out.println("createCommentNotificationRequest delete");
        return new CommentNotificationResponse();
    }
}
