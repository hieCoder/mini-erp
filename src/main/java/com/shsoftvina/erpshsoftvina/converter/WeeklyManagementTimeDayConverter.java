package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.WeeklyRequest;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class WeeklyManagementTimeDayConverter {

    @Autowired
    private UserMapper userMapper;

    public WeeklyManagementTimeDay toEntity(String userId, WeeklyRequest weeklyRequest){
        return WeeklyManagementTimeDay.builder()
                .code(DateUtils.formatDate(weeklyRequest.getStartDay()))
                .content(JsonUtils.objectToJson(weeklyRequest.getContent()))
                .user(userMapper.findById(userId)).build();
    }

    public WeeklyManagementTimeDay toEntity(String userId, String code, String content){
        return WeeklyManagementTimeDay.builder()
                .code(code)
                .content(content)
                .user(userMapper.findById(userId)).build();
    }
}
