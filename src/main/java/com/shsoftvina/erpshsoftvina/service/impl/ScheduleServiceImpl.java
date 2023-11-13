package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.TaskConverter;
import com.shsoftvina.erpshsoftvina.entity.Task;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.exception.InvalidException;
import com.shsoftvina.erpshsoftvina.mapper.ScheduleMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.response.schedule.ScheduleListResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.IdAndFullnameUserResponse;
import com.shsoftvina.erpshsoftvina.service.ScheduleService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService {

    @Autowired
    private ScheduleMapper scheduleMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserService userService;

    @Autowired
    private TaskConverter taskConverter;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Override
    public ScheduleListResponse getScheduleDetail(String userId, String monthly) {
        applicationUtils.checkUserAllow(userId);
        String firstDayOfMonth = monthly + "-01";
        LocalDate currentDate = LocalDate.parse(firstDayOfMonth);
        LocalDate previousDate = currentDate.minusMonths(1);
        LocalDate lastDayOfNextMonth = currentDate.plusMonths(1).with(TemporalAdjusters.lastDayOfMonth());
        List<Task> tasks = scheduleMapper.getScheduleDetailByMonth(userId, previousDate, lastDayOfNextMonth);
        List<User> users = userMapper.getUserBirthday(previousDate,lastDayOfNextMonth);
        List<ScheduleListResponse.TaskResponse> list = taskConverter.toListTaskResponseOfSchedule(tasks,users);
        IdAndFullnameUserResponse user = userService.findIdAndFullNameOfUser(userId);
        return new ScheduleListResponse(list, user);
    }
}

