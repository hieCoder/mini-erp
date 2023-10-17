package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.exception.ErrorResponse;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentNotificationResponse;
import com.shsoftvina.erpshsoftvina.service.CommentNotificationService;
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

import javax.validation.Valid;
import java.security.Principal;
import java.util.List;
import java.util.Map;

@Controller
public class CommentWebSocketController {
    @Autowired
    CommentNotificationService commentNotificationService;

    @MessageMapping("/comment")
    @SendTo("/notification/comments")
    public CommentNotificationResponse handleComment(
            @RequestBody CreateCommentNotificationRequest createCommentNotificationRequest,
            StompHeaderAccessor accessor) {
        String clientID = accessor.getFirstNativeHeader("clientID");
        CommentNotificationResponse commentNotificationResponse = commentNotificationService.createCommentNotification(createCommentNotificationRequest);
        commentNotificationResponse.setClientId(clientID);
        return commentNotificationResponse;
    }

    @MessageMapping("/editcomment")
    @SendTo("/notification/editcomments")
    public CommentNotificationResponse handleEditComment(
            @RequestBody UpdateCommentNotificationRequest updateCommentNotificationRequest,
            StompHeaderAccessor accessor
            ) {
        String clientID = accessor.getFirstNativeHeader("clientID");
        CommentNotificationResponse commentNotificationResponse = commentNotificationService.updateCommentNotification(updateCommentNotificationRequest);
        if(commentNotificationResponse != null){
            commentNotificationResponse.setClientId(clientID);
            return commentNotificationResponse;
        }
        return null;
    }

    @MessageMapping("/deletecomment")
    @SendTo("/notification/deletecomments")
    public CommentNotificationResponse handleDeleteComment(
            @RequestBody Map<String, String> requestBody,
            StompHeaderAccessor accessor
    ) {
        String clientID = accessor.getFirstNativeHeader("clientID");
        String id = requestBody.get("id");
        int rs = commentNotificationService.deleteCommentNotification(id);
        if(rs>0){
            CommentNotificationResponse commentNotificationResponse = new CommentNotificationResponse();
            commentNotificationResponse.setId(id);
            commentNotificationResponse.setClientId(clientID);
            return commentNotificationResponse;
        }
            return null;
    }

    @MessageMapping("/replycomment")
    @SendTo("/notification/replycomments")
    public CommentNotificationResponse handleReplyComment(
            @RequestBody CreateCommentNotificationRequest createCommentNotificationRequest,
            StompHeaderAccessor accessor
    ) {
        String clientID = accessor.getFirstNativeHeader("clientID");
        try{
            CommentNotificationResponse commentNotificationResponse = commentNotificationService.createCommentNotification(createCommentNotificationRequest);
            commentNotificationResponse.setClientId(clientID);
            return commentNotificationResponse;
        } catch(Exception e){
            System.out.println(e);
            return null;
        }
    }
}
