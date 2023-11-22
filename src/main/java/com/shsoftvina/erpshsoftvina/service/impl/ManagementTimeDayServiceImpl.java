package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.ManagementTimeDayConvert;
import com.shsoftvina.erpshsoftvina.converter.WeeklyManagementTimeDayConverter;
import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.ManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.ItemDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.OneThingCalendarDto;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarDayRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarWeeklyRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.WeeklyManagementTimeDayResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

        List<CalendarWeeklyRequest> weeklys = req.getWeeklys();
        for(CalendarWeeklyRequest w: weeklys){
            WeeklyManagementTimeDay weeklyEntity = weeklyManagementTimeDayMapper.findByCode(userId, DateUtils.formatDate(w.getStartDay()));
            if(weeklyEntity == null){
                weeklyEntity = weeklyManagementTimeDayConverter.toEntity(userId, w);
                weeklyManagementTimeDayMapper.createWeeklyManagementTimeDay(weeklyEntity);
            } else{
                weeklyEntity.setContent(JsonUtils.objectToJson(w.getContent()));
                weeklyManagementTimeDayMapper.updateWeeklyManagementTimeDay(weeklyEntity);
            }
        }

        return 1;
    }

    @Override
    public List<WeeklyManagementTimeDayResponse> showCalendar(String userId, String startDate, String endDate) {

        applicationUtils.checkUserAllow(userId);
        if(userMapper.findById(userId) == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        List<ManagementTimeDay> managementTimeDays = managementTimeDayMapper.findDays(userId, startDate, endDate);
        List<WeeklyManagementTimeDayResponse> rs = weeklyManagementTimeDayConverter.toListWeeklyResponse(userId, managementTimeDays);

        return rs;
    }

//    @Override
//    public DayResponse createDay(DayCreateRequest dayCreateRequest) {
//
//        if(userMapper.findById(dayCreateRequest.getUserId()) == null)
//            throw new NotFoundException(MessageErrorUtils.notFound("userId"));
//
//        ManagementTimeDay day = managementTimeConvert.toEntity(dayCreateRequest);
//        try{
//            Date currentDate = dayCreateRequest.getDay();
//            LocalDate firstDayOfWeek = getFisrtDateOfWeek(currentDate);
//            LocalDate lastDayOfWeek = getLastDateOfWeek(currentDate);
//            String userId = dayCreateRequest.getUserId();
//
//            WeeklyManagementTimeDay weeklyManagementTimeDay =
//                    weeklyManagementTimeDayMapper.findByStartDateAndEndDateOfUser(userId, firstDayOfWeek, lastDayOfWeek);
//            if(weeklyManagementTimeDay == null){
//
//                String generateCodeWeekly = "WEEKLY_CODE_" + ApplicationUtils.generateId();
//
//                WeeklyManagementTimeDay w = weeklyManagementTimeDayConverter.createWeeklyManagementTimeDay(
//                        generateCodeWeekly,
//                        firstDayOfWeek,
//                        lastDayOfWeek,
//                        dayCreateRequest.getUserId()
//                );
//                weeklyManagementTimeDayMapper.createWeeklyManagementTimeDay(w);
//
//                day.setWeeklyCode(generateCodeWeekly);
//            }else{
//                day.setWeeklyCode(weeklyManagementTimeDay.getCode());
//            }
//
//            managementTimeDayMapper.createDayInfo(day);
//
//            return managementTimeConvert.toResponse(day);
//        }catch (Exception e){
//            return null;
//        }
//    }
//
//    @Override
//    public DayResponse updateDay(DayUpdateRequest dayUpdateRequest) {
//
//        if(managementTimeDayMapper.findById(dayUpdateRequest.getId()) == null)
//            throw new NotFoundException(MessageErrorUtils.notFound("id"));
//
//        ManagementTimeDay day = managementTimeConvert.toEntity(dayUpdateRequest);
//        try{
//            managementTimeDayMapper.updateDayInfo(day);
//            return managementTimeConvert.toResponse(day);
//        }catch (Exception e){
//            return null;
//        }
//    }
//
//    @Override
//    public DayResponse findById(String id) {
//        ManagementTimeDay managementTimeDay = managementTimeDayMapper.findById(id);
//        if(managementTimeDay!= null){
//            applicationUtils.checkUserAllow(managementTimeDay.getUser().getId());
//            return managementTimeConvert.toResponse(managementTimeDay);
//        }
//        return null;
//    }
//
//    @Override
//    public DayResponse findByDay(String userId, String day) {
//        ManagementTimeDay managementTimeDay = managementTimeDayMapper.findByDay(userId, day);
//        if(managementTimeDay!= null){
//            applicationUtils.checkUserAllow(managementTimeDay.getUser().getId());
//            return managementTimeConvert.toResponse(managementTimeDay);
//        }
//        return null;
//    }
//
//    @Override
//    public DayResponse findDayResponse(String userId, String day, String id) {
//        DayResponse dayResponseId = findById(id);
//        if(dayResponseId == null){
//            DayResponse dayResponseDay = findByDay(userId, day);
//            if(dayResponseDay == null){
//                return null;
//            }
//            return dayResponseDay;
//        }
//        return dayResponseId;
//    }
}