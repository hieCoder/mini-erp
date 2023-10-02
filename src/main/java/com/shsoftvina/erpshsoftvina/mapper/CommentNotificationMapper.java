package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentNotificationMapper {
    int createCommentNotification(CommentNotification commentNotification);
    int updateCommentNotification(CommentNotification commentNotification);
    int deleteCommentNotificationNoChild(String id);
    int deleteCommentNotificationHasChild(String id);
    CommentNotification getCommentById(@Param("id") String id);
    CommentNotification getCommentChildById(@Param("id") String id);
}
