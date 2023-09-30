package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.CommentNotification;

import java.util.List;

public interface CommentNotificationMapper {
    int createCommentNotification(CommentNotification commentNotification);
    List<CommentNotification> getCommentsByNotificationId(String notificationId);
}
