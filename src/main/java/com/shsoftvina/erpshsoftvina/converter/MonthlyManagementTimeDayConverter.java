package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.MonthlyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarMonthlyRequest;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MonthlyManagementTimeDayConverter {

    @Autowired
    private UserMapper userMapper;

    public MonthlyManagementTimeDay toEntity(String userId, CalendarMonthlyRequest calendarMonthlyRequest){
        return MonthlyManagementTimeDay.builder()
                .code(calendarMonthlyRequest.getMonth())
                .content(JsonUtils.objectToJson(calendarMonthlyRequest.getContent()))
                .user(userMapper.findById(userId)).build();
    }
}
