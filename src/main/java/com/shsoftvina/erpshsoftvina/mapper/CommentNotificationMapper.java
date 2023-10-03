package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CommentNotificationMapper {
    int createCommentNotification(CommentNotification commentNotification);
    int updateCommentNotification(CommentNotification commentNotification);
    int deleteById(String id);
    CommentNotification findById(@Param("id") String id);
}
