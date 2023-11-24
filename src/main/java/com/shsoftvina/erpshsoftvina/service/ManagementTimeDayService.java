package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DaysUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DaysOfWeeklyResponse;

public interface ManagementTimeDayService {

    int updateCalendar(CalendarUpdateRequest req);
    CalendarResponse showCalendar(String userId, String startDate, String endDate);
    DaysOfWeeklyResponse showListDayOfWeek(String userId, String currentDay);
    int updateListDayOfWeek(DaysUpdateRequest daysUpdateRequest);
}
