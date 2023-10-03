package com.shsoftvina.erpshsoftvina.service.impl;


import com.shsoftvina.erpshsoftvina.converter.CommentNotificationConverter;
import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.CommentNotificationMapper;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentNotificationResponse;
import com.shsoftvina.erpshsoftvina.service.CommentNotificationService;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentNotificationServiceImpl implements CommentNotificationService {

    @Autowired
    CommentNotificationMapper commentNotificationMapper;

    @Autowired
    CommentNotificationConverter commentNotificationConverter;

    @Override
    public CommentNotificationResponse findById(String id) {
        CommentNotification commentNotification = commentNotificationMapper.findById(id);
        return commentNotificationConverter.toResponse(commentNotification);
    }

    @Override
    public int createCommentNotification(CreateCommentNotificationRequest createCommentNotificationRequest){
        return commentNotificationMapper.createCommentNotification(commentNotificationConverter.toEntity(createCommentNotificationRequest));
    }

    @Override
    public int updateCommentNotification(UpdateCommentNotificationRequest updateCommentNotificationRequest){
        if(commentNotificationMapper.findById(updateCommentNotificationRequest.getId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));
        CommentNotification commentNotification = commentNotificationConverter.toEntity(updateCommentNotificationRequest);
        return commentNotificationMapper.updateCommentNotification(commentNotification);
    }

    @Override
    public int deleteCommentNotification(String id){
        if(commentNotificationMapper.findById(id) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));
        return commentNotificationMapper.deleteById(id);
    }
}
