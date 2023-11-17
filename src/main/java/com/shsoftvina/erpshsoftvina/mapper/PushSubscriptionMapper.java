package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.PushSubscription;
import com.shsoftvina.erpshsoftvina.entity.Task;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Mapper
public interface PushSubscriptionMapper {
    int createPushSubscription(PushSubscription pushSubscription);
    int deletePushSubscription(String endpoint);
    List<PushSubscription> findAll(String id);
}
