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
import com.shsoftvina.erpshsoftvina.model.request.managementtime.DailyRoutineRequest;
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
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DailyRoutineResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.WeeklyManagementTimeDayResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DaysOfWeeklyResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.MonthResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.*;
import java.util.stream.Collectors;

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

    private static String[] getSundaysOfTheMonth(String dateString) {

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date = LocalDate.parse(dateString, formatter);
        List<String> sundays = new ArrayList<>();

        LocalDate firstDayOfMonth = date.withDayOfMonth(1);

        LocalDate firstSunday = firstDayOfMonth.with(DayOfWeek.SUNDAY);
        if (firstSunday.isAfter(firstDayOfMonth)) {
            firstSunday = firstSunday.minusWeeks(1);
        }

        LocalDate currentSunday = firstSunday;
        while (currentSunday.getMonthValue() == date.getMonthValue() || currentSunday.getMonthValue() == date.getMonthValue() - 1) {
            sundays.add(currentSunday.format(formatter));
            currentSunday = currentSunday.plusWeeks(1);
        }

        return sundays.toArray(new String[0]);
    }

    private static int[] mergeAndCountDailyRoutine(List<Boolean[]> list) {
        if (list.isEmpty()) {
            return new int[0];
        }

        int[] resultArray = new int[list.get(0).length];

        for (Boolean[] boolArray : list) {
            for (int i = 0; i < boolArray.length; i++) {
                if (boolArray[i]) {
                    resultArray[i]++;
                }
            }
        }

        return resultArray;
    }

    public static String getFirstDateOfWeek(String dateString) {
        // Định dạng để chuyển đổi chuỗi ngày tháng thành đối tượng LocalDate
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // Chuyển đổi chuỗi thành đối tượng LocalDate
        LocalDate currentDate = LocalDate.parse(dateString, formatter);

        // Xác định ngày đầu tuần
        LocalDate firstDateOfWeek = currentDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));

        // Định dạng kết quả thành chuỗi "yyyy-MM"
        String result = firstDateOfWeek.format(DateTimeFormatter.ofPattern("yyyy-MM"));

        return result;
    }

    private static String getLastDateOfWeek(String dateString) {
        // Định dạng để chuyển đổi chuỗi ngày tháng thành đối tượng LocalDate
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // Chuyển đổi chuỗi thành đối tượng LocalDate
        LocalDate currentDate = LocalDate.parse(dateString, formatter);

        // Xác định ngày cuối tuần
        LocalDate lastDateOfWeek = currentDate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SATURDAY));

        // Định dạng kết quả thành chuỗi "yyyy-MM"
        String result = lastDateOfWeek.format(DateTimeFormatter.ofPattern("yyyy-MM"));

        return result;
    }


    private static String[] getMonthContainWeek(String day) {
        String firstDateOfWeek = getFirstDateOfWeek(day);
        String lastDateOfWeek = getLastDateOfWeek(day);

        String[] containingMonths = null;

        if(firstDateOfWeek.equals(lastDateOfWeek)){
            containingMonths = new String[1];
            containingMonths[0] = firstDateOfWeek;
        } else{
            containingMonths = new String[2];
            containingMonths[0] = firstDateOfWeek;
            containingMonths[1] = lastDateOfWeek;
        }

        return containingMonths;
    }

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

        MonthlyManagementTimeDay monthlyManagementTimeDay = monthlyManagementTimeDayMapper.findByCode(userId, startDate.substring(0, 7));
        if(monthlyManagementTimeDay!= null){
            String[] monthlyContent = JsonUtils.jsonToObject(monthlyManagementTimeDay.getContent(), String[].class);
            calendarResponse.setMonthlyContents(monthlyContent);
        }

        List<WeeklyManagementTimeDayResponse> weeklys = new ArrayList<>();
        String[] weeklyCode = getSundaysOfTheMonth(startDate);
        for(String wc: weeklyCode){
            WeeklyManagementTimeDay weeklyE = weeklyManagementTimeDayMapper.findByCode(userId, wc);

            if(weeklyE!=null){
                WeeklyManagementTimeDayResponse weeklyR = WeeklyManagementTimeDayResponse.builder()
                        .weeklyId(weeklyE.getId())
                        .startDate(weeklyE.getCode())
                        .weeklyContents(JsonUtils.jsonToObject(weeklyE.getContent(), CalendarWeeklyContent.class))
                        .listDayOfWeek(managementTimeDayConvert.toListResponse(managementTimeDayMapper.findByCode(userId, wc))).build();
                weeklys.add(weeklyR);
            }
        }
        calendarResponse.setWeeklys(weeklys);

        return calendarResponse;
    }

    @Override
    public DaysOfWeeklyResponse showListDayOfWeek(String userId, String currentDay) {

        applicationUtils.checkUserAllow(userId);
        if(userMapper.findById(userId) == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        DaysOfWeeklyResponse daysOfWeeklyResponse = new DaysOfWeeklyResponse();

        List<MonthResponse> monthlys = new ArrayList<>();
        String[] monthContainWeek = getMonthContainWeek(currentDay);
        for(String month: monthContainWeek){
            MonthlyManagementTimeDay monthlyManagementTimeDay = monthlyManagementTimeDayMapper.findByCode(userId, month);
            if(monthlyManagementTimeDay!=null){
                MonthResponse monthResponse = new MonthResponse();
                monthResponse.setMonth(month);
                monthResponse.setMonthlyContents(JsonUtils.jsonToObject(monthlyManagementTimeDay.getContent(), String[].class));

                String dailyRoutineJson = monthlyManagementTimeDay.getDailyRoutine();
                if(!StringUtils.isBlank(dailyRoutineJson)){
                    DailyRoutineResponse[] dailyRoutineResponses = JsonUtils.jsonToObject(dailyRoutineJson, DailyRoutineResponse[].class);
                    List<ManagementTimeDay> list = managementTimeDayMapper.findAllDailyRoutineOfMonth(userId, monthlyManagementTimeDay.getCode());
                    List<Boolean[]> listDailyRoutine = list.stream()
                            .filter(day -> day != null)
                            .map(day -> JsonUtils.jsonToObject(day.getDailyRoutine(), Boolean[].class))
                            .collect(Collectors.toList());
                    int[] countDailyRoutines = mergeAndCountDailyRoutine(listDailyRoutine);

                    for(int i = 0; i < dailyRoutineResponses.length; i++){
                        dailyRoutineResponses[i].setPerformance(countDailyRoutines[i]);
                    }

                    monthResponse.setDailyRoutine(dailyRoutineResponses);
                }

                monthlys.add(monthResponse);
            }
        }
        daysOfWeeklyResponse.setMonthlys(monthlys);


        String weeklyCode = ApplicationUtils.generateWeeklyCodeOfDay(DateUtils.parseDate(currentDay));
        WeeklyManagementTimeDay weeklyManagementTimeDay = weeklyManagementTimeDayMapper.findByCode(userId, weeklyCode);
        WeeklyManagementTimeDayResponse weekly = WeeklyManagementTimeDayResponse.builder()
                .weeklyId(weeklyManagementTimeDay != null? weeklyManagementTimeDay.getId() : null)
                .startDate(weeklyManagementTimeDay != null? weeklyManagementTimeDay.getCode() : null)
                .weeklyContents(weeklyManagementTimeDay != null? JsonUtils.jsonToObject(weeklyManagementTimeDay.getContent(), CalendarWeeklyContent.class): null)
                .listDayOfWeek(managementTimeDayConvert.toListDayDetailResponse(managementTimeDayMapper.findByCode(userId, weeklyCode), weeklyCode)).build();
        daysOfWeeklyResponse.setWeeklys(weekly);

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
        DailyRoutineRequest[] dailyRoutine = monthlyRequest.getDailyRoutine();
        MonthlyManagementTimeDay monthlyEntity = monthlyManagementTimeDayMapper.findByCode(userId, monthlyCode);
        if(monthlyEntity == null){
            monthlyEntity = monthlyManagementTimeDayConverter.toEntity(userId, monthlyCode,
                    JsonUtils.objectToJson(monthlyContent),
                    JsonUtils.objectToJson(dailyRoutine));
            monthlyManagementTimeDayMapper.createMonthlyManagementTimeDay(monthlyEntity);
        } else{
            monthlyEntity.setContent(JsonUtils.objectToJson(monthlyContent));
            monthlyEntity.setDailyRoutine(JsonUtils.objectToJson(dailyRoutine));
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
        for(ManagementTimeDay managementTimeDay: managementTimeDays){
            ManagementTimeDay m = managementTimeDayMapper.findByDay(userId, managementTimeDay.getDay());
            if(m == null){
                managementTimeDayMapper.insertDay(managementTimeDay);
            } else{
                managementTimeDay.setId(m.getId());
                managementTimeDayMapper.editDay(managementTimeDay);
            }
        }

        return 1;
    }
}