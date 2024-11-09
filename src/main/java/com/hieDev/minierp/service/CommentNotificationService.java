package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.commentnotification.CreateCommentNotificationRequest;
import com.hieDev.minierp.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.hieDev.minierp.model.response.commentnotification.CommentNotificationResponse;

public interface CommentNotificationService {
    CommentNotificationResponse findById(String id);
    CommentNotificationResponse createCommentNotification(CreateCommentNotificationRequest createCommentNotificationRequest);
    CommentNotificationResponse updateCommentNotification(UpdateCommentNotificationRequest updateCommentNotificationRequest);
    int deleteCommentNotification(String id);
}
