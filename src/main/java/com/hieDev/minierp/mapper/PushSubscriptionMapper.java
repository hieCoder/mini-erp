package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.PushSubscription;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PushSubscriptionMapper {
    int createPushSubscription(PushSubscription pushSubscription);
    int deletePushSubscription(String endpoint);
    List<PushSubscription> findAll(String id);
}
