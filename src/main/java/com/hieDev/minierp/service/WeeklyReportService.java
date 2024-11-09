package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.hieDev.minierp.model.request.weeklyreport.UpdateWeeklyReportRequest;
import com.hieDev.minierp.model.response.weeklyReport.WeeklyReportDetailResponse;

import java.util.List;

public interface WeeklyReportService {
    List<WeeklyReportDetailResponse> getAllWeeklyReportByUser(String userId, int start, int pageSize);
    long getTotalWeeklyReportByUser(String userId);
    WeeklyReportDetailResponse findById(String id);
    int createWeeklyReport(CreateWeeklyReportRequest createWeeklyReportRequest);
    WeeklyReportDetailResponse updateWeeklyReport(UpdateWeeklyReportRequest updateWeeklyReportRequest);
    int deleteWeeklyReport(String id);
}
