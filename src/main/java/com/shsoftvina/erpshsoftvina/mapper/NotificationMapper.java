package com.shsoftvina.erpshsoftvina.mapper;


import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.enums.Notification.StatusNotificationEnum;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface NotificationMapper {

    List<Notification> getAllNoti(int start,
                                  int pageSize,
                                  String search,
                                  StatusNotificationEnum status
    );

    List<Notification> getInactiveNoti(int start,
                                  int pageSize,
                                  StatusNotificationEnum status
    );
    List<Notification> getNotificationLatest(int limit);
    Notification createNoti(Notification notification);
    boolean delNoti(String id, StatusNotificationEnum status);
    Notification findById(String id);
    int countAll(String search, StatusNotificationEnum status);
    int updateNotification(Notification notification);
    Notification getNotificationById(String id);
}