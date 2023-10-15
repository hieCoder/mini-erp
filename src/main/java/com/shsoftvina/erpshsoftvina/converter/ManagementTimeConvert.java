package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.DayDto;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class ManagementTimeConvert {

    @Autowired
    private UserMapper userMapper;

    public ManagementTimeDay toEntity(DayDto dayDto){
        return ManagementTimeDay.builder()
                .id(UUID.randomUUID().toString())
                .day(dayDto.getDay())
                .oneThingCalendar(JsonUtils.objectToJson(dayDto.getData().getOneThingCalendar()))
                .toDoList(JsonUtils.objectToJson(dayDto.getData().getToDoList()))
                .gratitudeDiary(JsonUtils.objectToJson(dayDto.getData().getAffirmation()))
                .affirmation(JsonUtils.objectToJson(dayDto.getData().getAffirmation()))
                .user(userMapper.findById(dayDto.getUserId()))
                .build();
    }
}
