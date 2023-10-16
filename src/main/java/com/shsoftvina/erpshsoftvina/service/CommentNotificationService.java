package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentNotificationResponse;

public interface CommentNotificationService {
    CommentNotificationResponse findById(String id);
    CommentNotificationResponse createCommentNotification(CreateCommentNotificationRequest createCommentNotificationRequest);
    int updateCommentNotification(UpdateCommentNotificationRequest updateCommentNotificationRequest);
    int deleteCommentNotification(String id);
}
