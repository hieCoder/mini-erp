package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentRequest;

public interface CommentNotificationService {
    int createCommentNotification(CreateCommentRequest createCommentRequest);
    int updateCommentNotification(UpdateCommentRequest updateCommentRequest);
    int deleteCommentNotification(String id);
}
