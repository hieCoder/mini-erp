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
import java.time.*;
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

    private static List<String> getSundaysOfTheMonth(String yyyyMMDD) {

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date = LocalDate.parse(yyyyMMDD, formatter);
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

        return sundays;
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

    private static List<String> getMonthContainWeek(String day) {
        String firstDateOfWeek = FileUtils.getFirstDateOfWeek(day);
        String lastDateOfWeek = FileUtils.getLastDateOfWeek(day);

        List<String> containingMonths = new ArrayList<>();

        if(firstDateOfWeek.equals(lastDateOfWeek)){
            containingMonths.add(firstDateOfWeek);
        } else{
            if(day.substring(0, 7).equals(firstDateOfWeek)){
                containingMonths.add(firstDateOfWeek);
                containingMonths.add(lastDateOfWeek);
            } else{
                containingMonths.add(lastDateOfWeek);
                containingMonths.add(firstDateOfWeek);
            }
        }

        return containingMonths;
    }

    private ManagementTimeDay getManagementTimeDays(List<ManagementTimeDay> managementTimeDays, Date day) {
        Optional<ManagementTimeDay> result = managementTimeDays.stream()
                .filter(m -> DateUtils.formatDate(day).equals(DateUtils.formatDate(m.getDay())))
                .findFirst();
        return result.orElse(null);
    }

    private WeeklyManagementTimeDay getWeeklyManagementTimeDays(List<WeeklyManagementTimeDay> weeklyManagementTimeDays, Date startDay) {
        Optional<WeeklyManagementTimeDay> result = weeklyManagementTimeDays.stream()
                .filter(m -> DateUtils.formatDate(startDay).equals(m.getCode()))
                .findFirst();
        return result.orElse(null);
    }

    public List<String> getDaysOfMonth(String monthString) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
        YearMonth yearMonth = YearMonth.parse(monthString, formatter);

        LocalDate firstDayOfMonth = yearMonth.atDay(1);

        LocalDate lastDayOfMonth = yearMonth.atEndOfMonth();

        List<String> dayList = new ArrayList<>();
        LocalDate currentDay = firstDayOfMonth;
        while (!currentDay.isAfter(lastDayOfMonth)) {
            dayList.add(currentDay.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            currentDay = currentDay.plusDays(1);
        }

        return dayList;
    }

    public static List<String> getSundaysOfMonth(String yyyyMM) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
        YearMonth yearMonth = YearMonth.parse(yyyyMM, formatter);

        LocalDate firstDayOfMonth = yearMonth.atDay(1);
        LocalDate lastDayOfMonth = yearMonth.atEndOfMonth();

        LocalDate firstSunday = firstDayOfMonth.with(DayOfWeek.SUNDAY);

        List<String> sundayList = new ArrayList<>();
        LocalDate currentSunday = firstSunday;
        while (!currentSunday.isAfter(lastDayOfMonth)) {
            sundayList.add(currentSunday.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            currentSunday = currentSunday.plusWeeks(1);
        }

        return sundayList;
    }

    @Override
    public int updateCalendar(CalendarUpdateRequest req) {
        String userId = req.getUserId();
        MonthlyRequest monthlyReq = req.getMonthly();
        String monthlyCode = monthlyReq.getMonth();
        List<WeeklyRequest> weeklys = req.getWeeklys();
        List<CalendarDayRequest> days = req.getDays();


        List<ManagementTimeDay> insertListDay = new ArrayList<>();
        List<ManagementTimeDay> editListDay = new ArrayList<>();
        if(days.size() != 0){
            List<String> dayList = days.stream().map(d -> DateUtils.formatDate(d.getDay())).collect(Collectors.toList());
            List<ManagementTimeDay> managementTimeDays = managementTimeDayMapper.findByListDay(userId, dayList);
            for(CalendarDayRequest d: days){
                ManagementTimeDay dayEntity = getManagementTimeDays(managementTimeDays, d.getDay());
                if(dayEntity !=null){
                    OneThingCalendarDto o = OneThingCalendarDto.builder()
                            .theSingleMostImportantThing(new ItemDto(d.getContent().getTheSingleMostImportantThing(), false))
                            .lecture(new ItemDto(d.getContent().getLecture(), false))
                            .dailyEvaluation(new ItemDto(d.getContent().getDailyEvaluation(), false))
                            .work(new ItemDto(d.getContent().getWork(), false))
                            .reading(new ItemDto(d.getContent().getReading(), false)).build();
                    dayEntity.setOneThingCalendar(JsonUtils.objectToJson(o));
                    editListDay.add(dayEntity);
                } else{
                    dayEntity = managementTimeDayConvert.toEntity(userId, d);
                    insertListDay.add(dayEntity);
                }
            }
            if(insertListDay.size()>0) managementTimeDayMapper.createListCalendarDay(insertListDay);
            if(editListDay.size()>0) managementTimeDayMapper.editListCalendarDay(editListDay);
            managementTimeDayMapper.updateOneThingCalendarNull(userId, dayList);
        } else{
            managementTimeDayMapper.updateOneThingCalendarAllDayNull(userId, getDaysOfMonth(monthlyCode));
        }


        List<WeeklyManagementTimeDay> insertListWeekly = new ArrayList<>();
        List<WeeklyManagementTimeDay> editListWeekly = new ArrayList<>();
        if(weeklys.size() != 0){
            List<String> startDayList = weeklys.stream().map(d -> DateUtils.formatDate(d.getStartDay())).collect(Collectors.toList());
            List<WeeklyManagementTimeDay> weeklyManagementTimeDays = weeklyManagementTimeDayMapper.findByListCode(userId, startDayList);
            for(WeeklyRequest w: weeklys){
                WeeklyManagementTimeDay weeklyEntity = getWeeklyManagementTimeDays(weeklyManagementTimeDays, w.getStartDay());
                if(weeklyEntity !=null){
                    weeklyEntity.setContent(JsonUtils.objectToJson(w.getContent()));
                    editListWeekly.add(weeklyEntity);
                } else{
                    weeklyEntity = weeklyManagementTimeDayConverter.toEntity(userId, w);
                    insertListWeekly.add(weeklyEntity);
                }
            }
            if(insertListWeekly.size()>0) weeklyManagementTimeDayMapper.createListWeekly(insertListWeekly);
            if(editListWeekly.size()>0) weeklyManagementTimeDayMapper.editListWeekly(editListWeekly);
            weeklyManagementTimeDayMapper.updateContentNull(userId, startDayList);
        } else{
            weeklyManagementTimeDayMapper.updateContentAllWeeklyNull(userId, getSundaysOfMonth(monthlyCode));
        }


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

        CalendarResponse calendarResponse = new CalendarResponse();

        MonthlyManagementTimeDay monthlyManagementTimeDay = monthlyManagementTimeDayMapper.findByCode(userId, startDate.substring(0, 7));
        if(monthlyManagementTimeDay!= null){
            String[] monthlyContent = JsonUtils.jsonToObject(monthlyManagementTimeDay.getContent(), String[].class);
            calendarResponse.setMonthlyContents(monthlyContent);
        }


        List<String> weeklyCode = getSundaysOfTheMonth(startDate);
        List<WeeklyManagementTimeDay> weeklys = weeklyManagementTimeDayMapper.findByListCode(userId, weeklyCode);
        List<ManagementTimeDay> days = managementTimeDayMapper.findByListCode(userId, weeklyCode);

//        List<WeeklyManagementTimeDayResponse> weeklysRs = weeklys.stream()
//                .filter(weeklyE -> weeklyE != null)
//                .map(weeklyE -> {
//                    List<ManagementTimeDay> filteredDays = days.stream()
//                            .filter(day -> weeklyE.getCode().equals(day.getWeeklyCode()) && day.getOneThingCalendar() != null)
//                            .collect(Collectors.toList());
//
//                    return WeeklyManagementTimeDayResponse.builder()
//                            .weeklyId(weeklyE.getId())
//                            .startDate(weeklyE.getCode())
//                            .weeklyContents(JsonUtils.jsonToObject(weeklyE.getContent(), CalendarWeeklyContent.class))
//                            .listDayOfWeek(managementTimeDayConvert.toListResponse(filteredDays))
//                            .build();
//                })
//                .collect(Collectors.toList());

        calendarResponse.setDays(managementTimeDayConvert.toListResponse(days));
        calendarResponse.setWeeklys(weeklyManagementTimeDayConverter.toListResponse(weeklys));

        return calendarResponse;
    }

    @Override
    public DaysOfWeeklyResponse showListDayOfWeek(String userId, String currentDay) {

        applicationUtils.checkUserAllow(userId);

        DaysOfWeeklyResponse daysOfWeeklyResponse = new DaysOfWeeklyResponse();

        List<MonthResponse> monthlys = new ArrayList<>();
        List<String> monthContainWeek = getMonthContainWeek(currentDay);
//        List<MonthlyManagementTimeDay> monthlyManagementTimeDays = monthlyManagementTimeDayMapper.findByListCode(userId, monthContainWeek);
//        for(MonthlyManagementTimeDay monthlyManagementTimeDay: monthlyManagementTimeDays){
//
//        }


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
                //.listDayOfWeek(managementTimeDayConvert.toListDayDetailResponse(managementTimeDayMapper.findByCode(userId, weeklyCode), weeklyCode))
        .build();
        daysOfWeeklyResponse.setWeeklys(weekly);

        return daysOfWeeklyResponse;
    }

    @Override
    public int updateListDayOfWeek(DaysUpdateRequest daysUpdateRequest) {

        String userId = daysUpdateRequest.getUserId();

        applicationUtils.checkUserAllow(userId);
//        if(userMapper.findById(userId) == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));

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