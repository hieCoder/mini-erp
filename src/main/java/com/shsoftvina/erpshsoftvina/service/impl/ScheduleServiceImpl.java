package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.TaskConverter;
import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.ScheduleMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.response.schedule.ScheduleListResponse;
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
    private UserMapper userMapper;

    @Autowired
    private TaskConverter taskConverter;

    @Autowired
    private UserConverter userConverter;

    @Override
    public ScheduleListResponse getScheduleDetail(String userId, Date startDate, Date endDate) {
        List<TaskShowResponse> list = scheduleMapper.getScheduleDetail(userId, startDate, endDate).stream().map(task -> taskConverter.toResponse(task)).collect(Collectors.toList());
        User user = userMapper.findById(userId);
        return new ScheduleListResponse(list,userConverter.toAccountResponse(user));
    }
}

