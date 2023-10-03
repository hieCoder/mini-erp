package com.shsoftvina.erpshsoftvina.service.impl;


import com.shsoftvina.erpshsoftvina.converter.CommentNotificationConverter;
import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.mapper.CommentNotificationMapper;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentRequest;
import com.shsoftvina.erpshsoftvina.service.CommentNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentNotificationServiceImpl implements CommentNotificationService {
    @Autowired
    CommentNotificationMapper commentNotificationMapper;

    @Override
    public int createCommentNotification(CreateCommentRequest createCommentRequest){
        String parentId = createCommentRequest.getParentId();
        CommentNotification commentNotification = CommentNotificationConverter.createCommentRequestToEntity(createCommentRequest);
        if(parentId == null){
            return commentNotificationMapper.createCommentNotification(commentNotification);
        } else{
            CommentNotification commentNotificationDb = commentNotificationMapper.getCommentById(parentId);
            if(commentNotificationDb.getParentId() == null){
                return commentNotificationMapper.createCommentNotification(commentNotification);
            }
            return 0;
        }
    }

    @Override
    public int updateCommentNotification(UpdateCommentRequest updateCommentRequest){
        CommentNotification commentNotification = CommentNotificationConverter.updateCommentRequestToEntity(updateCommentRequest);
        return commentNotificationMapper.updateCommentNotification(commentNotification);
    }

    @Override
    public int deleteCommentNotification(String id){
        CommentNotification commentChild = commentNotificationMapper.getCommentChildById(id);
        if(commentChild == null){
            return commentNotificationMapper.deleteCommentNotificationNoChild(id);
        }
        return commentNotificationMapper.deleteCommentNotificationHasChild(id);
    }
}
