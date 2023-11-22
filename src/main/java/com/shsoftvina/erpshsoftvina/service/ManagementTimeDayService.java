package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.WeeklyManagementTimeDayResponse;

import java.util.List;

public interface ManagementTimeDayService {

    int updateCalendar(CalendarUpdateRequest req);
//    DayResponse createDay(DayCreateRequest dayCreateRequest);
//    DayResponse updateDay(DayUpdateRequest dayUpdateRequest);
//    DayResponse findById(String id);
//    DayResponse findByDay(String userId, String day);
//    DayResponse findDayResponse(String userId, String day, String id);
    List<WeeklyManagementTimeDayResponse> showCalendar(String userId, String startDate, String endDate);
    WeeklyManagementTimeDayResponse showListDayOfWeek(String userId, String currentDay);
}
