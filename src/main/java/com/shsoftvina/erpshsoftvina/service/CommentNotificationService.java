package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentsByNotificationIdResponse;

import java.util.List;

public interface CommentNotificationService {
    int createCommentNotification(CreateCommentRequest createCommentRequest);
    CommentsByNotificationIdResponse getCommentsByNotificationId(String notificationId);
}
