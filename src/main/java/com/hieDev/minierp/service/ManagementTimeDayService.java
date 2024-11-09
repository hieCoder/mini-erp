package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.managementtime.calendar.CalendarUpdateRequest;
import com.hieDev.minierp.model.request.managementtime.day.DaysUpdateRequest;
import com.hieDev.minierp.model.request.managementtime.day.SpendingMonthRequest;
import com.hieDev.minierp.model.response.managementtime.calendar.CalendarResponse;
import com.hieDev.minierp.model.response.managementtime.day.DaysOfWeeklyResponse;
import com.hieDev.minierp.model.response.managementtime.day.MonthResponse;
import com.hieDev.minierp.model.response.managementtime.day.SpendingMonthResponse;

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
