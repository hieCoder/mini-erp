package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.CommentNotificationMapper;
import com.shsoftvina.erpshsoftvina.mapper.NotificationMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentNotificationResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.Collectors;

@Component
public class CommentNotificationConverter {

    @Autowired
    private NotificationMapper notificationMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CommentNotificationMapper commentNotificationMapper;

    public CommentNotificationResponse toResponse(CommentNotification commentNotification) {

        User user = commentNotification.getUser();
        String avatarUser = null, fullnameUser = null;
        if(commentNotification.getUser() != null){
            avatarUser = user.getAvatar();
            fullnameUser = user.getFullname();
        }

        return CommentNotificationResponse.builder()
                .id(commentNotification.getId())
                .content(commentNotification.getContent())
                .createdDate(DateUtils.formatDateTime(commentNotification.getCreatedDate()))
                .modifiedBy(commentNotification.getModifiedBy())
                .modifiedDate(DateUtils.formatDateTime(commentNotification.getModifiedDate()))
                .avatarUser(avatarUser)
                .fullnameUser(fullnameUser)
                .childComments(toListResponse(commentNotification.getChildComments()))
                .build();
    }

    public List<CommentNotificationResponse> toListResponse(List<CommentNotification> commentNotifications) {
        if(commentNotifications == null) return null;
        return commentNotifications.stream().map(c -> toResponse(c)).collect(Collectors.toList());
    }

    public CommentNotification toEntity(CreateCommentNotificationRequest createCommentNotificationRequest) {

        return CommentNotification.builder().id(UUID.randomUUID().toString())
                .content(createCommentNotificationRequest.getContent())
                .createdDate(new Date())
                .notification(notificationMapper.findById(createCommentNotificationRequest.getNotificationId()))
                .user(userMapper.findById(createCommentNotificationRequest.getUserId()))
                .parentComment(commentNotificationMapper.findById(createCommentNotificationRequest.getParentId()))
                .build();
    }

    public CommentNotification toEntity(UpdateCommentNotificationRequest updateCommentNotificationRequest) {
        return CommentNotification.builder()
                .content(updateCommentNotificationRequest.getContent())
                .id(updateCommentNotificationRequest.getId())
                .modifiedBy(Principal.getUserCurrent().getFullname())
                .modifiedDate(new Date())
                .build();
    }
}
