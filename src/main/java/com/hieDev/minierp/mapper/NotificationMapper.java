package com.hieDev.minierp.mapper;


import com.hieDev.minierp.entity.Notification;
import com.hieDev.minierp.enums.Notification.StatusNotificationEnum;
import org.apache.ibatis.annotations.Mapper;

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