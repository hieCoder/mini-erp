package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;

import java.util.List;

public interface ManagementTimeDayService {
    DayResponse createDay(DayCreateRequest dayCreateRequest);
    DayResponse updateDay(DayUpdateRequest dayUpdateRequest);
    DayResponse findById(String id);
    List<DayResponse> findAllByMonthYear(String userId, String month, String year);
}
