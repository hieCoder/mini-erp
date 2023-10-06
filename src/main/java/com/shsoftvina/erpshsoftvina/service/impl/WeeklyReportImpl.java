package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.WeeklyReportConverter;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyReportMapper;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;
import com.shsoftvina.erpshsoftvina.service.WeeklyReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class WeeklyReportImpl implements WeeklyReportService {

    @Autowired
    WeeklyReportMapper weeklyReportMapper;

    @Autowired
    WeeklyReportConverter weeklyReportConverter;

    @Override
    public List<WeeklyReportShowResponse> getAllWeeklyReport(int page, int pageSize, String searchTerm) {
        return weeklyReportMapper.getAllWeeklyReport(page, pageSize, searchTerm)
                .stream().map(weeklyReport -> weeklyReportConverter.toEntity(weeklyReport)).collect(Collectors.toList());
    }

    @Override
    public WeeklyReportDetailResponse findById(String id) {
        return weeklyReportConverter.toDetailResponse(weeklyReportMapper.findById(id));
    }

    @Override
    public int createWeeklyReport(CreateWeeklyReportRequest createWeeklyReportRequest) {
        return weeklyReportMapper.createWeeklyReport(weeklyReportConverter.toEntity(createWeeklyReportRequest));
    }
}
