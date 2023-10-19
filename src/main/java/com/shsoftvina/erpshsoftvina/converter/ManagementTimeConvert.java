package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.ManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.DataOfDayDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.OneThingCalendarDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.ToDoListDto;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.UUID;

@Component
public class ManagementTimeConvert {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ManagementTimeDayMapper managementTimeDayMapper;

    public DayResponse toResponse(ManagementTimeDay day){

        DataOfDayDto data = new DataOfDayDto();
        data.setOneThingCalendar(JsonUtils.jsonToObject(day.getOneThingCalendar(), OneThingCalendarDto.class));
        data.setToDoList(JsonUtils.jsonToObject(day.getToDoList(), ToDoListDto.class));
        data.setGratitudeDiary(JsonUtils.jsonToObject(day.getGratitudeDiary(), List.class));
        data.setAffirmation(day.getAffirmation());

        return DayResponse.builder()
                .id(day.getId())
                .day(DateUtils.formatDate(day.getDay()))
                .data(data)
                .build();
    }

    public ManagementTimeDay toEntity(DayCreateRequest dayCreateRequest){

        DataOfDayDto dataRequest = dayCreateRequest.getData();

        return ManagementTimeDay.builder()
                .id(ApplicationUtils.generateId())
                .day(dayCreateRequest.getDay())
                .oneThingCalendar(JsonUtils.objectToJson(dataRequest.getOneThingCalendar()))
                .toDoList(JsonUtils.objectToJson(dataRequest.getToDoList()))
                .gratitudeDiary(JsonUtils.objectToJson(dataRequest.getGratitudeDiary()))
                .affirmation(dataRequest.getAffirmation())
                .user(userMapper.findById(dayCreateRequest.getUserId()))
                .build();
    }

    public ManagementTimeDay toEntity(DayUpdateRequest dayUpdateRequest){

        ManagementTimeDay day = managementTimeDayMapper.findById(dayUpdateRequest.getId());

        DataOfDayDto dataRequest = dayUpdateRequest.getData();

        day.setOneThingCalendar(JsonUtils.objectToJson(dataRequest.getOneThingCalendar()));
        day.setToDoList(JsonUtils.objectToJson(dataRequest.getToDoList()));
        day.setGratitudeDiary(JsonUtils.objectToJson(dataRequest.getGratitudeDiary()));
        day.setAffirmation(dataRequest.getAffirmation());

        return day;
    }
}
