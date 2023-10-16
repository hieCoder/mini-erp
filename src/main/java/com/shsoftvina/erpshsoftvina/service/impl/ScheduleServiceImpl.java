package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.TaskConverter;
import com.shsoftvina.erpshsoftvina.mapper.ScheduleMapper;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;
import com.shsoftvina.erpshsoftvina.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ScheduleServiceImpl implements ScheduleService {

    @Autowired
    private ScheduleMapper scheduleMapper;

    @Autowired
    private TaskConverter taskConverter;

    @Override
    public List<TaskShowResponse> getScheduleDetail(String userId, Date startDate, Date endDate) {
        return scheduleMapper.getScheduleDetail(userId, startDate, endDate).stream().map(task -> taskConverter.toResponse(task)).collect(Collectors.toList());
    }
}