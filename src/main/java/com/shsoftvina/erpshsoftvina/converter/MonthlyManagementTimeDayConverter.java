package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.MonthlyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.MonthlyRequest;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MonthlyManagementTimeDayConverter {

    @Autowired
    private UserMapper userMapper;

    public MonthlyManagementTimeDay toEntity(String userId, MonthlyRequest monthlyRequest){
        return MonthlyManagementTimeDay.builder()
                .code(monthlyRequest.getMonth())
                .content(JsonUtils.objectToJson(monthlyRequest.getContent()))
                .user(userMapper.findById(userId)).build();
    }

    public MonthlyManagementTimeDay toEntity(String userId, String code, String content){
        return MonthlyManagementTimeDay.builder()
                .code(code)
                .content(content)
                .user(userMapper.findById(userId)).build();
    }
}
