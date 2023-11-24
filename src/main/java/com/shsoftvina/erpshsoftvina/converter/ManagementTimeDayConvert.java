package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.DataOfDayDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.ItemDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.OneThingCalendarDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.ToDoListDto;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarDayRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayRequest;
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
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class ManagementTimeDayConvert {

    @Autowired
    private UserMapper userMapper;

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
                .weeklyCode(ApplicationUtils.generateWeeklyCodeOfDay(day))
                .build();
    }

    public DayResponse toResponse(ManagementTimeDay day){
        if(day == null) return null;
        DataOfDayDto data = new DataOfDayDto();
        data.setOneThingCalendar(JsonUtils.jsonToObject(day.getOneThingCalendar(), OneThingCalendarDto.class));
        data.setToDoList(JsonUtils.jsonToObject(day.getToDoList(), ToDoListDto.class));
        data.setGratitudeDiary(JsonUtils.jsonToObject(day.getGratitudeDiary(), String[].class));
        data.setAffirmation(day.getAffirmation());
        data.setComplimentForMeToday(day.getComplimentForMeToday());
        data.setTodaysReflectionsAndImprovements(day.getTodaysReflectionsAndImprovements());
        data.setToDoDetail(JsonUtils.jsonToObject(day.getToDoDetail(), String[].class));
        data.setDailyRoutine(JsonUtils.jsonToObject(day.getDailyRoutine(), Boolean[].class));

        return DayResponse.builder()
                .id(day.getId())
                .day(DateUtils.formatDate(day.getDay()))
                .data(data)
                .build();
    }

    public List<DayResponse> toListResponse(List<ManagementTimeDay> days){
        return days.stream().map(this::toResponse).collect(Collectors.toList());
    }

    private ManagementTimeDay isDayExistInList(List<ManagementTimeDay> days, LocalDate localDate){
        for(ManagementTimeDay day: days){
            if(DateUtils.formatDate(day.getDay()).equals(DateUtils.formatDate(localDate))) return day;
        }
        return null;
    }

    public List<DayResponse> toListDayDetailResponse(List<ManagementTimeDay> days, String weeklyCode){

        List<DayResponse> dayResponses = new ArrayList<>();

        LocalDate date = LocalDate.parse(weeklyCode, DateTimeFormatter.ISO_LOCAL_DATE);
        LocalDate startDay = date.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));

        for (int i = 0; i < 7; i++) {
            ManagementTimeDay managementTimeDay = isDayExistInList(days, startDay);
            if(managementTimeDay!=null){
                dayResponses.add(toResponse(managementTimeDay));
            }else{
                DayResponse dayResponse = DayResponse.builder().day(DateUtils.formatDate(startDay)).build();
                dayResponses.add(dayResponse);
            }
            startDay = startDay.plusDays(1);
        }

        return dayResponses;
    }

    public ManagementTimeDay toEntity(String userId, DayRequest dayRequest){

        DataOfDayDto dataRequest = dayRequest.getData();

        return ManagementTimeDay.builder()
                .day(dayRequest.getDay())
                .oneThingCalendar(JsonUtils.objectToJson(dataRequest.getOneThingCalendar()))
                .toDoList(JsonUtils.objectToJson(dataRequest.getToDoList()))
                .gratitudeDiary(JsonUtils.objectToJson(dataRequest.getGratitudeDiary()))
                .affirmation(dataRequest.getAffirmation())
                .complimentForMeToday(dataRequest.getComplimentForMeToday())
                .todaysReflectionsAndImprovements(dataRequest.getTodaysReflectionsAndImprovements())
                .toDoDetail(JsonUtils.objectToJson(dataRequest.getToDoDetail()))
                .dailyRoutine(JsonUtils.objectToJson(dataRequest.getDailyRoutine()))
                .weeklyCode(ApplicationUtils.generateWeeklyCodeOfDay(dayRequest.getDay()))
                .user(userMapper.findById(userId))
                .build();
    }

    public List<ManagementTimeDay> toListEntity(String userId, DayRequest[] dayRequests) {
        return Arrays.stream(dayRequests).map(e -> this.toEntity(userId, e)).collect(Collectors.toList());
    }
}
