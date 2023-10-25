package com.shsoftvina.erpshsoftvina.service.impl;


import com.shsoftvina.erpshsoftvina.converter.CommentNotificationConverter;
import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.Notification.StatusNotificationEnum;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.CommentNotificationMapper;
import com.shsoftvina.erpshsoftvina.mapper.NotificationMapper;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentNotificationResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.CommentNotificationService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

@Service
public class CommentNotificationServiceImpl implements CommentNotificationService {

    @Autowired
    CommentNotificationMapper commentNotificationMapper;

    @Autowired
    CommentNotificationConverter commentNotificationConverter;

    @Autowired
    private NotificationMapper notificationMapper;

    @Override
    public CommentNotificationResponse findById(String id) {
        CommentNotification commentNotification = commentNotificationMapper.findById(id);
        return commentNotificationConverter.toResponse(commentNotification);
    }

    @Override
    public CommentNotificationResponse createCommentNotification(CreateCommentNotificationRequest createCommentNotificationRequest){
        Notification notificationDb = notificationMapper.getNotificationById(createCommentNotificationRequest.getNotificationId());
        if(notificationDb == null || notificationDb.getStatus().equals(StatusNotificationEnum.INACTIVE)){
            return new CommentNotificationResponse();
        }
        CommentNotification commentNotification = commentNotificationConverter.toEntity(createCommentNotificationRequest);
        commentNotificationMapper.createCommentNotification(commentNotification);
        return commentNotificationConverter.toResponse(commentNotification);
    }

    @Override
    public CommentNotificationResponse updateCommentNotification(UpdateCommentNotificationRequest updateCommentNotificationRequest){
        if(commentNotificationMapper.findById(updateCommentNotificationRequest.getId()) == null){
            return new CommentNotificationResponse();
        }
        CommentNotification commentNotification = commentNotificationConverter.toEntity(updateCommentNotificationRequest);
        int rs = commentNotificationMapper.updateCommentNotification(commentNotification);
        if(rs>0){
            return commentNotificationConverter.toResponse(commentNotification);
        }
        return new CommentNotificationResponse();
    }

    @Override
    public int deleteCommentNotification(String id){
        if(commentNotificationMapper.findById(id) == null)
            return 0;
        return commentNotificationMapper.deleteById(id);
    }
}
