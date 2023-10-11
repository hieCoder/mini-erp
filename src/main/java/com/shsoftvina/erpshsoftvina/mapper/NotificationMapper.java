package com.shsoftvina.erpshsoftvina.mapper;


import com.shsoftvina.erpshsoftvina.entity.Notification;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface NotificationMapper {

    List<Notification> getAllNoti(@Param("start") int start,
                                  @Param("pageSize") int pageSize,
                                  @Param("search") String search);
    Notification createNoti(Notification notification);
    Notification updateNoti(Notification notification);
    boolean delNoti(String id);
    Notification findById(String id);
    int countAll(@Param("search") String search);
}