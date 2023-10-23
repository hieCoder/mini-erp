package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.ManagementTimeConvert;
import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.ManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
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
import java.util.stream.Collectors;

@Service
public class ManagementTimeDayServiceImpl implements ManagementTimeDayService {

    @Autowired
    private ManagementTimeConvert managementTimeConvert;

    @Autowired
    private ManagementTimeDayMapper managementTimeDayMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Autowired
    private WeeklyManagementTimeDayMapper weeklyManagementTimeDayMapper;

    private LocalDate getFisrtDateOfWeek(Date currentDate){
        Instant instant = currentDate.toInstant();
        LocalDate currentLocalDate = instant.atZone(ZoneId.systemDefault()).toLocalDate();
        return currentLocalDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));
    }

    private LocalDate getLastDateOfWeek(Date currentDate){
        Instant instant = currentDate.toInstant();
        LocalDate currentLocalDate = instant.atZone(ZoneId.systemDefault()).toLocalDate();
        return currentLocalDate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SATURDAY));
    }

    @Override
    public DayResponse createDay(DayCreateRequest dayCreateRequest) {

        if(userMapper.findById(dayCreateRequest.getUserId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        ManagementTimeDay day = managementTimeConvert.toEntity(dayCreateRequest);
        try{
            managementTimeDayMapper.createDayInfo(day);


            Date currentDate = dayCreateRequest.getDay();
            LocalDate firstDayOfWeek = getFisrtDateOfWeek(currentDate);
            LocalDate lastDayOfWeek = getLastDateOfWeek(currentDate);
            String userId = dayCreateRequest.getUserId();

//            WeeklyManagementTimeDay weeklyManagementTimeDay =
//                    weeklyManagementTimeDayMapper.findByStartDateAndEndDateOfUser(userId, firstDayOfWeek, lastDayOfWeek);
//            System.out.println(weeklyManagementTimeDay);



            return managementTimeConvert.toResponse(day);
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public DayResponse updateDay(DayUpdateRequest dayUpdateRequest) {

        if(managementTimeDayMapper.findById(dayUpdateRequest.getId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        ManagementTimeDay day = managementTimeConvert.toEntity(dayUpdateRequest);
        try{
            managementTimeDayMapper.updateDayInfo(day);
            return managementTimeConvert.toResponse(day);
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public DayResponse findById(String id) {
        ManagementTimeDay managementTimeDay = managementTimeDayMapper.findById(id);
        if(managementTimeDay!= null){
            applicationUtils.checkUserAllow(managementTimeDay.getUser().getId());
            return managementTimeConvert.toResponse(managementTimeDay);
        }
        return null;
    }

    @Override
    public DayResponse findByDay(String userId, String day) {
        ManagementTimeDay managementTimeDay = managementTimeDayMapper.findByDay(userId, day);
        if(managementTimeDay!= null){
            applicationUtils.checkUserAllow(managementTimeDay.getUser().getId());
            return managementTimeConvert.toResponse(managementTimeDay);
        }
        return null;
    }

    @Override
    public DayResponse findDayResponse(String userId, String day, String id) {
        DayResponse dayResponseId = findById(id);
        if(dayResponseId == null){
            DayResponse dayResponseDay = findByDay(userId, day);
            if(dayResponseDay == null){
                return null;
            }
            return dayResponseDay;
        }
        return dayResponseId;
    }


    @Override
    public List<DayResponse> findAllByMonthYear(String userId, String startDate, String endDate) {

        applicationUtils.checkUserAllow(userId);

        if(userMapper.findById(userId) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        return managementTimeDayMapper.findAllByMonthYear(userId, startDate, endDate)
                .stream().map(day -> managementTimeConvert.toResponse(day))
                .collect(Collectors.toList());
    }
}