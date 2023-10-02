package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.converter.user.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentResponse;
import com.shsoftvina.erpshsoftvina.model.response.users.UserCommentResponse;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class CommentNotificationConverter {
    public static CommentNotification createCommentRequestToEntity(CreateCommentRequest createCommentRequest) {
        User user = new User();
        user.setId(createCommentRequest.getUserId());
        Notification notification = new Notification();
        notification.setId(createCommentRequest.getNotificationId());
        return CommentNotification.builder()
                .id(UUID.randomUUID().toString())
                .notification(notification)
                .content(createCommentRequest.getContent())
                .user(user)
                .parentId(createCommentRequest.getParentId())
                .build();
    }

    public static CommentNotification updateCommentRequestToEntity(UpdateCommentRequest updateCommentRequest) {
        return CommentNotification.builder()
                .content(updateCommentRequest.getContent())
                .id(updateCommentRequest.getId())
                .build();
    }

    public CommentResponse commentToResponse(CommentNotification commentNotification) {
        List<CommentResponse> childCommentResponses = new ArrayList<>();
        List<CommentNotification>  childComment =  commentNotification.getChildComments();
        if(childComment!=null){
             childCommentResponses = commentNotification.getChildComments().stream()
                    .map(this::commentToResponse)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());
        }

        UserCommentResponse userCommentResponse = UserConverter.toUserCommentResponse(commentNotification.getUser());
                return CommentResponse.builder()
                .id(commentNotification.getId())
                .content(commentNotification.getContent())
                .createdDate(commentNotification.getCreatedDate())
                .parentId(commentNotification.getParentId())
                .user(userCommentResponse)
                .childComments(childCommentResponses)
                .build();
    }
}
