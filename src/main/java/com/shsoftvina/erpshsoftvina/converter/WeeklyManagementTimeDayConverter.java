package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.WeeklyRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarDayRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarWeeklyContent;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.WeeklyManagementTimeDayResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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

    public List<WeeklyManagementTimeDay> toListEntity(String userId, List<WeeklyRequest> weeklyRequests){
        List<WeeklyManagementTimeDay> list = new ArrayList<>();
        for(WeeklyRequest w: weeklyRequests){
            list.add(toEntity(userId, w));
        }
        return list;
    }

    public WeeklyManagementTimeDay toEntity(String userId, String code, String content){
        return WeeklyManagementTimeDay.builder()
                .code(code)
                .content(content)
                .user(userMapper.findById(userId)).build();
    }

    public WeeklyManagementTimeDayResponse toResponse(WeeklyManagementTimeDay weeklyManagementTimeDay){
        return WeeklyManagementTimeDayResponse.builder()
                .weeklyId(weeklyManagementTimeDay.getId())
                .startDate(weeklyManagementTimeDay.getCode())
                .weeklyContents(JsonUtils.jsonToObject(weeklyManagementTimeDay.getContent(), CalendarWeeklyContent.class)).build();
    }

    public List<WeeklyManagementTimeDayResponse> toListResponse(List<WeeklyManagementTimeDay> weeklyManagementTimeDays){
        return weeklyManagementTimeDays.stream().map(this::toResponse).collect(Collectors.toList());
    }
}
