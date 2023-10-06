package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.UUID;

@Component
public class WeeklyReportConverter {

    @Autowired
    UserMapper userMapper;

    public WeeklyReportShowResponse toEntity(WeeklyReport weeklyReport) {
        if (weeklyReport == null) return null;
        return WeeklyReportShowResponse.builder()
                .id(weeklyReport.getId())
                .title(weeklyReport.getTitle())
                .fullnameUser(weeklyReport.getUser().getFullname())
                .createdDate(DateUtils.formatDateTime(weeklyReport.getCreatedDate()))
                .build();
    }

    public WeeklyReportDetailResponse toDetailResponse(WeeklyReport weeklyReport) {
        if (weeklyReport == null) return null;
        return WeeklyReportDetailResponse.builder()
                .id(weeklyReport.getId())
                .title(weeklyReport.getTitle())
                .content(weeklyReport.getContent())
                .fullnameUser(weeklyReport.getUser().getFullname())
                .createdDate(DateUtils.formatDateTime(weeklyReport.getCreatedDate()))
                .build();
    }

    public WeeklyReport toEntity(CreateWeeklyReportRequest createWeeklyReportRequest) {
        if (createWeeklyReportRequest == null) return null;
        return WeeklyReport.builder()
                .id(UUID.randomUUID().toString())
                .title(createWeeklyReportRequest.getTitle())
                .content(createWeeklyReportRequest.getContent())
                .createdDate(new Date())
                .user(userMapper.findById(createWeeklyReportRequest.getUserId()))
                .build();
    }

}
