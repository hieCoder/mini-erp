package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyReportMapper;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.UpdateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.UserShowResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class WeeklyReportConverter {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserConverter userConverter;

    @Autowired
    private WeeklyReportMapper weeklyReportMapper;

    public WeeklyReportDetailResponse toDetailResponse(WeeklyReport weeklyReport) {
        if (weeklyReport == null) return null;
        return WeeklyReportDetailResponse.builder()
                .id(weeklyReport.getId())
                .title(weeklyReport.getTitle())
                .currentWeeklyContent(weeklyReport.getCurrentWeeklyContent())
                .nextWeeklyContent(weeklyReport.getNextWeeklyContent())
                .user(userConverter.toIdAndFullnameUserResponse(weeklyReport.getUser()))
                .createdDate(DateUtils.formatDateTime(weeklyReport.getCreatedDate()))
                .build();
    }

    public WeeklyReport toEntity(CreateWeeklyReportRequest createWeeklyReportRequest) {
        return WeeklyReport.builder()
                .id(ApplicationUtils.generateId())
                .title(createWeeklyReportRequest.getTitle())
                .currentWeeklyContent(createWeeklyReportRequest.getCurrentWeeklyContent())
                .nextWeeklyContent(createWeeklyReportRequest.getNextWeeklyContent())
                .createdDate(new Date())
                .user(userMapper.findById(createWeeklyReportRequest.getUserId()))
                .build();
    }

    public WeeklyReport toEntity(UpdateWeeklyReportRequest updateWeeklyReportRequest) {
        WeeklyReport weeklyReport = weeklyReportMapper.findById(updateWeeklyReportRequest.getId());
        weeklyReport.setTitle(updateWeeklyReportRequest.getTitle());
        weeklyReport.setCurrentWeeklyContent(updateWeeklyReportRequest.getCurrentWeeklyContent());
        weeklyReport.setNextWeeklyContent(updateWeeklyReportRequest.getNextWeeklyContent());
        return weeklyReport;
    }
}
