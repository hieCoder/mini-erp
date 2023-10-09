package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.WeeklyReportConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyReportMapper;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.WeeklyReportService;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
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

    @Autowired
    UserMapper userMapper;

    @Override
    public List<WeeklyReportShowResponse> getAllWeeklyReport(int page, int pageSize) {

        User currentUser = Principal.getUserCurrent();
        if(currentUser.getRole().equals(RoleEnum.DEVELOPER)){
            return weeklyReportMapper.getAllWeeklyReportByUserId(page, pageSize, currentUser.getId())
                    .stream().map(weeklyReport -> weeklyReportConverter.toShowResponse(weeklyReport)).collect(Collectors.toList());
        }

        return weeklyReportMapper.getAllWeeklyReport(page, pageSize)
                .stream().map(weeklyReport -> weeklyReportConverter.toShowResponse(weeklyReport)).collect(Collectors.toList());
    }

    @Override
    public WeeklyReportDetailResponse findById(String id) {
        return weeklyReportConverter.toDetailResponse(weeklyReportMapper.findById(id));
    }

    @Override
    public int createWeeklyReport(CreateWeeklyReportRequest createWeeklyReportRequest) {

        User user = userMapper.findById(createWeeklyReportRequest.getUserId());
        if (user == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        return weeklyReportMapper.createWeeklyReport(weeklyReportConverter.toEntity(createWeeklyReportRequest));
    }
}
