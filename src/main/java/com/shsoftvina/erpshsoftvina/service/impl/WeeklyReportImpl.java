package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.WeeklyReportConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyReportMapper;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.PageWeeklyReportListRespone;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.WeeklyReportService;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.apache.ibatis.session.RowBounds;
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
    public PageWeeklyReportListRespone getAllWeeklyReport(String searchTerm, String userRole, String userId, int start, int pageSize) {
        int offset = (start - 1) * pageSize;
        RowBounds rowBounds = new RowBounds(offset, pageSize);
        List<WeeklyReport> listWeeklyReport = weeklyReportMapper.getAllWeeklyReport(searchTerm, userRole, userId, rowBounds);
        List<WeeklyReportShowResponse> showWeeklyReport = weeklyReportConverter.toListShowWeeklyReportResponse(listWeeklyReport);
        long totalRecordCount = weeklyReportMapper.getTotalWeeklyReport(searchTerm, userRole, userId);
        long totalPage = (long) Math.ceil((double) totalRecordCount / pageSize);
        boolean hasNext = start < totalPage;
        boolean hasPrevious = start > 1;

        return new PageWeeklyReportListRespone(showWeeklyReport, start, totalPage, pageSize, hasNext, hasPrevious);
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
