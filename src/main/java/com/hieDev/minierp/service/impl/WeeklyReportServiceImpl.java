package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.converter.WeeklyReportConverter;
import com.hieDev.minierp.exception.NotFoundException;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.entity.WeeklyReport;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.mapper.WeeklyReportMapper;
import com.hieDev.minierp.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.hieDev.minierp.model.request.weeklyreport.UpdateWeeklyReportRequest;
import com.hieDev.minierp.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.hieDev.minierp.service.WeeklyReportService;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.MessageErrorUtils;
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
    public WeeklyReportDetailResponse updateWeeklyReport(UpdateWeeklyReportRequest updateWeeklyReportRequest) {
        WeeklyReport weeklyReport = weeklyReportMapper.findById(updateWeeklyReportRequest.getId());
        if (weeklyReport == null) throw new NotFoundException(MessageErrorUtils.notFound("id"));
        try{
            weeklyReport = weeklyReportConverter.toEntity(updateWeeklyReportRequest);
            weeklyReportMapper.updateWeeklyReport(weeklyReport);
            return weeklyReportConverter.toDetailResponse(weeklyReport);
        }catch (Exception e){}
        return null;
    }

    @Override
    public int deleteWeeklyReport(String id) {
        WeeklyReport weeklyReport = weeklyReportMapper.findById(id);
        if (weeklyReport == null) throw new NotFoundException(MessageErrorUtils.notFound("id"));
        try {
            return weeklyReportMapper.deleteWeeklyReport(id);
        }catch (Exception e) {}

        return 0;
    }
}
