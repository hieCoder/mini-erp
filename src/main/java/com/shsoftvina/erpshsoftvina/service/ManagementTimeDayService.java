package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DaysUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.SpendingMonthRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DaysOfWeeklyResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.MonthResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.SpendingMonthResponse;

import java.util.List;

public interface ManagementTimeDayService {

    int updateCalendar(CalendarUpdateRequest req);
    CalendarResponse showCalendar(String userId, String startDate, String endDate);
    DaysOfWeeklyResponse showListDayOfWeek(String userId, String currentDay);
    int updateListDayOfWeek(DaysUpdateRequest daysUpdateRequest);
    int updateSpendingMonth(SpendingMonthRequest spendingMonthRequest);
    SpendingMonthResponse showSpendingMonth(String userId, String monthCode);
    List<MonthResponse> monthOfYear(String userId, String year);
}
