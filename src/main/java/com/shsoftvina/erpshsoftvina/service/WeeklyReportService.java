package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.PageUserListRespone;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.PageWeeklyReportListRespone;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;

import java.util.List;

public interface WeeklyReportService {
    PageWeeklyReportListRespone getAllWeeklyReport(String searchTerm,
                                           String userRole,
                                           String userId,
                                           int start,
                                           int pageSize);
    WeeklyReportDetailResponse findById(String id);
    int createWeeklyReport(CreateWeeklyReportRequest createWeeklyReportRequest);
}
