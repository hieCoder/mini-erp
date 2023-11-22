package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.DataOfDayDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.ItemDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.OneThingCalendarDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.ToDoListDto;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarDayRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class ManagementTimeDayConvert {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private WeeklyManagementTimeDayMapper weeklyManagementTimeDayMapper;

    private String generateWeeklyCodeOfDay(Date currentDate) {
        Instant instant = currentDate.toInstant();
        LocalDate currentLocalDate = instant.atZone(ZoneId.systemDefault()).toLocalDate();
        currentLocalDate = currentLocalDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));
        return DateUtils.formatDate(currentLocalDate);
    }

    public ManagementTimeDay toEntity(String userId, CalendarDayRequest calendarDayRequest){

        OneThingCalendarDto o = OneThingCalendarDto.builder()
                .theSingleMostImportantThing(new ItemDto(calendarDayRequest.getContent().getTheSingleMostImportantThing(), false))
                .lecture(new ItemDto(calendarDayRequest.getContent().getLecture(), false))
                .dailyEvaluation(new ItemDto(calendarDayRequest.getContent().getDailyEvaluation(), false))
                .work(new ItemDto(calendarDayRequest.getContent().getWork(), false))
                .reading(new ItemDto(calendarDayRequest.getContent().getReading(), false)).build();

        Date day = calendarDayRequest.getDay();
        return ManagementTimeDay.builder()
                .id(ApplicationUtils.generateId())
                .oneThingCalendar(JsonUtils.objectToJson(o))
                .day(day)
                .user(userMapper.findById(userId))
                .weeklyCode(generateWeeklyCodeOfDay(day))
                .build();
    }


//    @Autowired
//    private ManagementTimeDayMapper managementTimeDayMapper;
//
    public DayResponse toResponse(ManagementTimeDay day){
        if(day == null) return null;
        DataOfDayDto data = new DataOfDayDto();
        data.setOneThingCalendar(JsonUtils.jsonToObject(day.getOneThingCalendar(), OneThingCalendarDto.class));
        data.setToDoList(JsonUtils.jsonToObject(day.getToDoList(), ToDoListDto.class));
        data.setGratitudeDiary(JsonUtils.jsonToObject(day.getGratitudeDiary(), String[].class));
        data.setAffirmation(day.getAffirmation());
        data.setToDoDetail(JsonUtils.jsonToObject(day.getToDoDetail(), String[].class));

        return DayResponse.builder()
                .id(day.getId())
                .day(DateUtils.formatDate(day.getDay()))
                .data(data)
                .build();
    }

    public List<DayResponse> toListResponse(List<ManagementTimeDay> days){
        return days.stream().map(this::toResponse).collect(Collectors.toList());
    }
//
//    public ManagementTimeDay toEntity(DayCreateRequest dayCreateRequest){
//
//        DataOfDayDto dataRequest = dayCreateRequest.getData();
//
//        return ManagementTimeDay.builder()
//                .id(ApplicationUtils.generateId())
//                .day(dayCreateRequest.getDay())
//                .oneThingCalendar(JsonUtils.objectToJson(dataRequest.getOneThingCalendar()))
//                .toDoList(JsonUtils.objectToJson(dataRequest.getToDoList()))
//                .gratitudeDiary(JsonUtils.objectToJson(dataRequest.getGratitudeDiary()))
//                .affirmation(dataRequest.getAffirmation())
//                .user(userMapper.findById(dayCreateRequest.getUserId()))
//                .build();
//    }
//
//    public ManagementTimeDay toEntity(DayUpdateRequest dayUpdateRequest){
//
//        ManagementTimeDay day = managementTimeDayMapper.findById(dayUpdateRequest.getId());
//
//        DataOfDayDto dataRequest = dayUpdateRequest.getData();
//
//        day.setOneThingCalendar(JsonUtils.objectToJson(dataRequest.getOneThingCalendar()));
//        day.setToDoList(JsonUtils.objectToJson(dataRequest.getToDoList()));
//        day.setGratitudeDiary(JsonUtils.objectToJson(dataRequest.getGratitudeDiary()));
//        day.setAffirmation(dataRequest.getAffirmation());
//
//        return day;
//    }
}
