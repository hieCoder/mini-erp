package com.shsoftvina.erpshsoftvina.service.impl;


import com.shsoftvina.erpshsoftvina.converter.CommentNotificationConverter;
import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.mapper.CommentNotificationMapper;
import com.shsoftvina.erpshsoftvina.mapper.NotificationMapper;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentsByNotificationIdResponse;
import com.shsoftvina.erpshsoftvina.service.CommentNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentNotificationServiceImpl implements CommentNotificationService {
    @Autowired
    CommentNotificationMapper commentNotificationMapper;

    @Autowired
    NotificationMapper notificationMapper;

    @Override
    public int createCommentNotification(CreateCommentRequest createCommentRequest){
        CommentNotification commentNotification = CommentNotificationConverter.createCommentRequestToEntity(createCommentRequest);
        return commentNotificationMapper.createCommentNotification(commentNotification);
    }

    @Override
    public CommentsByNotificationIdResponse getCommentsByNotificationId(String notificationId){
           System.out.println(notificationId);
           List<CommentNotification> comments = notificationMapper.getCommentsByNotificationId(notificationId);
           System.out.println(comments);
           return null;
    }
}
