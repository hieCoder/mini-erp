package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;

import java.util.List;

public interface ManagementTimeDayService {
    DayResponse createDay(String jsonDay);
    DayResponse updateDay(String jsonDay);
    DayResponse findById(String id);
    List<DayResponse> findAllByMonthYear(String userId, String month, String year);
}
