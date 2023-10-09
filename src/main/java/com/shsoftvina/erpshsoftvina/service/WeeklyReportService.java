package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;

import java.util.List;

public interface WeeklyReportService {
    List<WeeklyReportShowResponse> getAllWeeklyReport(int page, int pageSize);
    WeeklyReportDetailResponse findById(String id);
    int createWeeklyReport(CreateWeeklyReportRequest createWeeklyReportRequest);
}
