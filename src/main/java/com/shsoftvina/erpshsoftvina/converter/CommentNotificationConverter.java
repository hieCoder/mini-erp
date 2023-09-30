package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.UUID;

public class CommentNotificationConverter {
    public static CommentNotification createCommentRequestToEntity(CreateCommentRequest createCommentRequest) {
        return CommentNotification.builder()
                .id(UUID.randomUUID().toString())
                .notification(createCommentRequest.getNotification())
                .content(createCommentRequest.getContent())
                .user(createCommentRequest.getUser())
                .build();
    }
}
