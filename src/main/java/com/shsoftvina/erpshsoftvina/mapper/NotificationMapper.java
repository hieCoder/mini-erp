package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface NotificationMapper {

    List<Notification> getAllNoti(@Param("start") int start,
                                  @Param("pageSize") int pageSize);
    Notification findById(@Param("id") String id);
    int createNoti(Notification notification);
    int updateNoti(Notification notification);
    boolean delNoti(String id);
    List<CommentNotification> getCommentsByNotificationId(@Param("notificationId") String notificationId);
}