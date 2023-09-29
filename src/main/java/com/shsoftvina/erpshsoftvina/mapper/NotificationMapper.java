package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationResponse;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface NotificationMapper {

    List<Notification> getAllNoti(@Param("start") int start,
                                  @Param("pageSize") int pageSize);
    Notification findById(@Param("id") String id);
    Notification createNoti(Notification notification);
    Notification updateNoti(Notification notification);
    boolean delNoti(String id);
}