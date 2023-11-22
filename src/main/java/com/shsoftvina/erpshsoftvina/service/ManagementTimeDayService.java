package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DaysUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.WeeklyManagementTimeDayResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DaysOfWeeklyResponse;

public interface ManagementTimeDayService {

    int updateCalendar(CalendarUpdateRequest req);
//    DayResponse createDay(DayCreateRequest dayCreateRequest);
//    DayResponse updateDay(DayUpdateRequest dayUpdateRequest);
//    DayResponse findById(String id);
//    DayResponse findByDay(String userId, String day);
//    DayResponse findDayResponse(String userId, String day, String id);
    CalendarResponse showCalendar(String userId, String startDate, String endDate);
    DaysOfWeeklyResponse showListDayOfWeek(String userId, String currentDay);
    int updateListDayOfWeek(DaysUpdateRequest daysUpdateRequest);
}
