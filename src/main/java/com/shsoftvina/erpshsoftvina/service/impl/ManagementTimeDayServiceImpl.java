package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.ManagementTimeDayConvert;
import com.shsoftvina.erpshsoftvina.converter.MonthlyManagementTimeDayConverter;
import com.shsoftvina.erpshsoftvina.converter.WeeklyManagementTimeDayConverter;
import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.MonthlyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.ManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.mapper.MonthlyManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.ItemDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.OneThingCalendarDto;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.CalendarContent;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarDayRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.MonthlyRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.WeeklyRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DaysUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarWeeklyContent;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.WeeklyManagementTimeDayResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DaysOfWeeklyResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import java.util.List;

@Service
public class ManagementTimeDayServiceImpl implements ManagementTimeDayService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ManagementTimeDayMapper managementTimeDayMapper;

    @Autowired
    private ManagementTimeDayConvert managementTimeDayConvert;

    @Autowired
    private WeeklyManagementTimeDayMapper weeklyManagementTimeDayMapper;

    @Autowired
    private WeeklyManagementTimeDayConverter weeklyManagementTimeDayConverter;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Autowired
    private MonthlyManagementTimeDayMapper monthlyManagementTimeDayMapper;

    @Autowired
    private MonthlyManagementTimeDayConverter monthlyManagementTimeDayConverter;

    @Override
    public int updateCalendar(CalendarUpdateRequest req) {
        String userId = req.getUserId();
        if(userMapper.findById(userId) == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        List<CalendarDayRequest> days = req.getDays();
        for(CalendarDayRequest d: days){
            ManagementTimeDay dayEntity = managementTimeDayMapper.findByDay(userId, d.getDay());
            if(dayEntity == null){
                dayEntity = managementTimeDayConvert.toEntity(userId, d);
                managementTimeDayMapper.createCalendarDay(dayEntity);
            } else{

                OneThingCalendarDto o = OneThingCalendarDto.builder()
                        .theSingleMostImportantThing(new ItemDto(d.getContent().getTheSingleMostImportantThing(), false))
                        .lecture(new ItemDto(d.getContent().getLecture(), false))
                        .dailyEvaluation(new ItemDto(d.getContent().getDailyEvaluation(), false))
                        .work(new ItemDto(d.getContent().getWork(), false))
                        .reading(new ItemDto(d.getContent().getReading(), false)).build();
                dayEntity.setOneThingCalendar(JsonUtils.objectToJson(o));

                managementTimeDayMapper.updateCalendarDay(dayEntity);
            }
        }

        List<WeeklyRequest> weeklys = req.getWeeklys();
        for(WeeklyRequest w: weeklys){
            WeeklyManagementTimeDay weeklyEntity = weeklyManagementTimeDayMapper.findByCode(userId, DateUtils.formatDate(w.getStartDay()));
            if(weeklyEntity == null){
                weeklyEntity = weeklyManagementTimeDayConverter.toEntity(userId, w);
                weeklyManagementTimeDayMapper.createWeeklyManagementTimeDay(weeklyEntity);
            } else{
                weeklyEntity.setContent(JsonUtils.objectToJson(w.getContent()));
                weeklyManagementTimeDayMapper.updateWeeklyManagementTimeDay(weeklyEntity);
            }
        }

        MonthlyRequest monthlyReq = req.getMonthly();
        String monthlyCode = monthlyReq.getMonth();

        MonthlyManagementTimeDay monthlyEntity = monthlyManagementTimeDayMapper.findByCode(userId, monthlyCode);
        if(monthlyEntity == null){
            monthlyEntity = monthlyManagementTimeDayConverter.toEntity(userId, monthlyReq);
            monthlyManagementTimeDayMapper.createMonthlyManagementTimeDay(monthlyEntity);
        } else{
            monthlyEntity.setContent(JsonUtils.objectToJson(monthlyReq.getContent()));
            monthlyManagementTimeDayMapper.updateMonthlyManagementTimeDay(monthlyEntity);
        }
        return 1;
    }

    @Override
    public CalendarResponse showCalendar(String userId, String startDate, String endDate) {

        applicationUtils.checkUserAllow(userId);
        if(userMapper.findById(userId) == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        CalendarResponse calendarResponse = new CalendarResponse();

        List<ManagementTimeDay> managementTimeDays = managementTimeDayMapper.findDays(userId, startDate, endDate);
        List<WeeklyManagementTimeDayResponse> data = weeklyManagementTimeDayConverter.toListWeeklyResponse(userId, managementTimeDays);
        calendarResponse.setWeeklys(data);

        MonthlyManagementTimeDay monthlyManagementTimeDay = monthlyManagementTimeDayMapper.findByCode(userId, startDate.substring(0, 7));
        if(monthlyManagementTimeDay!= null){
            String[] monthlyContent = JsonUtils.jsonToObject(monthlyManagementTimeDay.getContent(), String[].class);
            calendarResponse.setMonthlyContents(monthlyContent);
        }

        return calendarResponse;
    }

    @Override
    public DaysOfWeeklyResponse showListDayOfWeek(String userId, String currentDay) {

        applicationUtils.checkUserAllow(userId);
        if(userMapper.findById(userId) == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        String weeklyCode = ApplicationUtils.generateWeeklyCodeOfDay(DateUtils.parseDate(currentDay));
        WeeklyManagementTimeDay weeklyManagementTimeDay = weeklyManagementTimeDayMapper.findByCode(userId, weeklyCode);

        MonthlyManagementTimeDay monthlyManagementTimeDay = monthlyManagementTimeDayMapper.findByCode(userId, currentDay.substring(0, 7));

        List<ManagementTimeDay> daysOfWeek = managementTimeDayMapper.findByCode(userId, weeklyCode);

        DaysOfWeeklyResponse daysOfWeeklyResponse = new DaysOfWeeklyResponse();
        WeeklyManagementTimeDayResponse weekly = WeeklyManagementTimeDayResponse.builder()
                .weeklyId(weeklyManagementTimeDay.getId())
                .startDate(weeklyManagementTimeDay.getCode())
                .weeklyContents(JsonUtils.jsonToObject(weeklyManagementTimeDay.getContent(), CalendarWeeklyContent.class))
                .listDayOfWeek(managementTimeDayConvert.toListResponse(daysOfWeek)).build();
        daysOfWeeklyResponse.setWeeklys(weekly);
        daysOfWeeklyResponse.setMonthlyContents(JsonUtils.jsonToObject(monthlyManagementTimeDay.getContent(), String[].class));
        return daysOfWeeklyResponse;
    }

    @Override
    public int updateListDayOfWeek(DaysUpdateRequest daysUpdateRequest) {

        String userId = daysUpdateRequest.getUserId();

        applicationUtils.checkUserAllow(userId);
        if(userMapper.findById(userId) == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        MonthlyRequest monthlyRequest = daysUpdateRequest.getMonthly();
        String monthlyCode = monthlyRequest.getMonth();
        String[] monthlyContent = monthlyRequest.getContent();
        MonthlyManagementTimeDay monthlyEntity = monthlyManagementTimeDayMapper.findByCode(userId, monthlyCode);
        if(monthlyEntity == null){
            monthlyEntity = monthlyManagementTimeDayConverter.toEntity(userId, monthlyCode, JsonUtils.objectToJson(monthlyContent));
            monthlyManagementTimeDayMapper.createMonthlyManagementTimeDay(monthlyEntity);
        } else{
            monthlyEntity.setContent(JsonUtils.objectToJson(monthlyContent));
            monthlyManagementTimeDayMapper.updateMonthlyManagementTimeDay(monthlyEntity);
        }

        WeeklyRequest weeklyRequest = daysUpdateRequest.getWeekly();
        String weeklyCode = DateUtils.formatDate(weeklyRequest.getStartDay());
        CalendarContent weeklyContent = weeklyRequest.getContent();
        WeeklyManagementTimeDay weeklyEntity = weeklyManagementTimeDayMapper.findByCode(userId, weeklyCode);
        if(weeklyEntity == null){
            weeklyEntity = weeklyManagementTimeDayConverter.toEntity(userId, weeklyCode, JsonUtils.objectToJson(weeklyContent));
            weeklyManagementTimeDayMapper.createWeeklyManagementTimeDay(weeklyEntity);
        } else{
            weeklyEntity.setContent(JsonUtils.objectToJson(weeklyContent));
            weeklyManagementTimeDayMapper.updateWeeklyManagementTimeDay(weeklyEntity);
        }

        DayRequest[] days = daysUpdateRequest.getDays();
        List<ManagementTimeDay> managementTimeDays = managementTimeDayConvert.toListEntity(userId, days);
        managementTimeDayMapper.insertDaysBatch(managementTimeDays);

        return 1;
    }
}