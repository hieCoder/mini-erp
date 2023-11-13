package com.shsoftvina.erpshsoftvina.mapper;


import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.enums.Notification.StatusNotificationEnum;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface NotificationMapper {

    List<Notification> getAllNoti(@Param("start") int start,
                                  @Param("pageSize") int pageSize,
                                  @Param("search") String search,
                                  @Param("status") StatusNotificationEnum status
    );

    List<Notification> getInactiveNoti(@Param("start") int start,
                                  @Param("pageSize") int pageSize,
                                  @Param("status") StatusNotificationEnum status
    );
    List<Notification> getNotificationLatest(@Param("limit") int limit);
    Notification createNoti(Notification notification);
    boolean delNoti(@Param("id") String id, @Param("status") StatusNotificationEnum status);
    Notification findById(String id);
    int countAll(@Param("search") String search, @Param("status") StatusNotificationEnum status);
    int updateNotification(Notification notification);
    Notification getNotificationById(String id);
}