package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.exception.ErrorResponse;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentNotificationResponse;
import com.shsoftvina.erpshsoftvina.service.CommentNotificationService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.security.core.Authentication;


import javax.validation.Valid;
import java.security.Principal;
import java.util.List;
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
        if(applicationUtils.checkUserCurrentAllow(createCommentNotificationRequest.getUserId())){
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
        if(applicationUtils.checkUserCurrentAllow(updateCommentNotificationRequest.getUserId())) {
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
        if(applicationUtils.checkUserCurrentAllow(requestBody.get("userId"))) {
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
        if(applicationUtils.checkUserCurrentAllow()){
            commentNotificationResponse = commentNotificationService.createCommentNotification(createCommentNotificationRequest);
        }
        commentNotificationResponse.setClientId(clientID);
        return commentNotificationResponse;
    }
}
