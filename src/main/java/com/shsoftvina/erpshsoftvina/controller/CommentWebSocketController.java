package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentNotificationResponse;
import com.shsoftvina.erpshsoftvina.service.CommentNotificationService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

@Controller
public class CommentWebSocketController {
    @Autowired
    CommentNotificationService commentNotificationService;
    @Autowired
    private ApplicationUtils applicationUtils;

    @MessageMapping("/comment")
    @SendTo("/notification/comments")
    public CommentNotificationResponse handleComment(
            @RequestBody CreateCommentNotificationRequest createCommentNotificationRequest,
            StompHeaderAccessor accessor) {
        String clientID = accessor.getFirstNativeHeader("clientID");
        CommentNotificationResponse commentNotificationResponse = new CommentNotificationResponse();
        if(applicationUtils.isUserAllow(createCommentNotificationRequest.getUserId())){
             commentNotificationResponse = commentNotificationService.createCommentNotification(createCommentNotificationRequest);
        }
        commentNotificationResponse.setClientId(clientID);
        commentNotificationResponse.setNotificationId(createCommentNotificationRequest.getNotificationId());
        return commentNotificationResponse;
    }

    @MessageMapping("/editcomment")
    @SendTo("/notification/editcomments")
    public CommentNotificationResponse handleEditComment(
            @RequestBody UpdateCommentNotificationRequest updateCommentNotificationRequest,
            StompHeaderAccessor accessor) {
        CommentNotificationResponse commentNotificationResponse = new CommentNotificationResponse();
        String clientID = accessor.getFirstNativeHeader("clientID");
        if(applicationUtils.isUserAllow(updateCommentNotificationRequest.getUserId())) {
            commentNotificationResponse = commentNotificationService.updateCommentNotification(updateCommentNotificationRequest);
        }
        commentNotificationResponse.setClientId(clientID);
        return commentNotificationResponse;
    }

    @MessageMapping("/deletecomment")
    @SendTo("/notification/deletecomments")
    public CommentNotificationResponse handleDeleteComment(
            @RequestBody Map<String, String> requestBody,
            StompHeaderAccessor accessor) {
        CommentNotificationResponse commentNotificationResponse = new CommentNotificationResponse();
        String clientID = accessor.getFirstNativeHeader("clientID");
        if(applicationUtils.isUserAllow(requestBody.get("userId"))) {
            String id = requestBody.get("id");
            int rs = commentNotificationService.deleteCommentNotification(id);
            if (rs > 0) {
                commentNotificationResponse.setId(id);
            }
        }
        commentNotificationResponse.setClientId(clientID);
        return commentNotificationResponse;
    }

    @MessageMapping("/replycomment")
    @SendTo("/notification/replycomments")
    public CommentNotificationResponse handleReplyComment(
            @RequestBody CreateCommentNotificationRequest createCommentNotificationRequest,
            StompHeaderAccessor accessor) {
        String clientID = accessor.getFirstNativeHeader("clientID");
        CommentNotificationResponse commentNotificationResponse = new CommentNotificationResponse();
        if(applicationUtils.isUserAllow()){
            commentNotificationResponse = commentNotificationService.createCommentNotification(createCommentNotificationRequest);
        }
        commentNotificationResponse.setClientId(clientID);
        return commentNotificationResponse;
    }
}
