package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.WeeklyManagementTimeDayConverter;
import com.shsoftvina.erpshsoftvina.converter.WeeklyReportConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyReportMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.weekly.WeeklyManagementTimeDayUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.PageWeeklyReportListRespone;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;
import com.shsoftvina.erpshsoftvina.service.WeeklyManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.service.WeeklyReportService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WeeklyManagementTimeDayServiceImpl implements WeeklyManagementTimeDayService {

    @Autowired
    private WeeklyManagementTimeDayMapper weeklyManagementTimeDayMapper;

    @Autowired
    private WeeklyManagementTimeDayConverter weeklyManagementTimeDayConverter;

    @Override
    public int updateWeekly(WeeklyManagementTimeDayUpdateRequest weeklyManagementTimeDayUpdateRequest) {

        try{
            WeeklyManagementTimeDay weeklyManagementTimeDay = weeklyManagementTimeDayConverter.toUpdateWeeklyManagementTimeDay(
                    weeklyManagementTimeDayUpdateRequest.getId(), weeklyManagementTimeDayUpdateRequest.getContent()
            );
            weeklyManagementTimeDayMapper.updateWeeklyManagementTimeDay(weeklyManagementTimeDay);
            return 1;
        } catch (Exception e){

        }
        return 0;
    }
}
