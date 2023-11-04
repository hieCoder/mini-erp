package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.WeeklyReportConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyReportMapper;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.UpdateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.PageWeeklyReportListRespone;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.WeeklyReportService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class WeeklyReportServiceImpl implements WeeklyReportService {

    @Autowired
    WeeklyReportMapper weeklyReportMapper;

    @Autowired
    WeeklyReportConverter weeklyReportConverter;

    @Autowired
    UserMapper userMapper;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Override
    public List<WeeklyReportDetailResponse> getAllWeeklyReportByUser(String userId, int start, int pageSize) {
        int offset = (start - 1) * pageSize;
        RowBounds rowBounds = new RowBounds(offset, pageSize);
        List<WeeklyReportDetailResponse> listWeeklyReport = weeklyReportMapper.getAllWeeklyReportByUser(userId, rowBounds)
                .stream().map(weeklyReport -> weeklyReportConverter.toDetailResponse(weeklyReport)).collect(Collectors.toList());
        return listWeeklyReport;
    }

    @Override
    public long getTotalWeeklyReportByUser(String userId) {
        return weeklyReportMapper.getTotalWeeklyReportByUser(userId);
    }

    @Override
    public WeeklyReportDetailResponse findById(String id) {
        WeeklyReport weeklyReport = weeklyReportMapper.findById(id);
        applicationUtils.checkUserAllow(weeklyReport.getUser().getId());
        return weeklyReportConverter.toDetailResponse(weeklyReport);
    }

    @Override
    public int createWeeklyReport(CreateWeeklyReportRequest createWeeklyReportRequest) {
        User user = userMapper.findById(createWeeklyReportRequest.getUserId());
        if (user == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));
        try{
            WeeklyReport weeklyReport = weeklyReportConverter.toEntity(createWeeklyReportRequest);
            weeklyReportMapper.createWeeklyReport(weeklyReport);
            return 1;
        }catch (Exception e){}
        return 0;
    }

    @Override
    public int updateWeeklyReport(UpdateWeeklyReportRequest updateWeeklyReportRequest) {
        WeeklyReport weeklyReport = weeklyReportMapper.findById(updateWeeklyReportRequest.getId());
        if (weeklyReport == null) throw new NotFoundException(MessageErrorUtils.notFound("id"));
        try{
            weeklyReport = weeklyReportConverter.toEntity(updateWeeklyReportRequest);
            weeklyReportMapper.updateWeeklyReport(weeklyReport);
            return 1;
        }catch (Exception e){}
        return 0;
    }
}
