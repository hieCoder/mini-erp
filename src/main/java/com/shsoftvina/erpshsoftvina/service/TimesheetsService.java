package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.response.timesheets.TimesheetsResponse;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TimesheetsService {
    List<TimesheetsResponse> findAll(int start, int pageSize);
    List<Map<String, ?>> getTotalWorkDayByYear(String userID);
    List<Map<String, ?>> getTotalWorkDayByMonth(String userID, String year);
}