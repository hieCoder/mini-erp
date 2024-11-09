package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.converter.TaskConverter;
import com.hieDev.minierp.entity.Task;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.mapper.ScheduleMapper;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.response.schedule.ScheduleListResponse;
import com.hieDev.minierp.model.response.user.IdAndFullnameUserResponse;
import com.hieDev.minierp.service.ScheduleService;
import com.hieDev.minierp.service.UserService;
import com.hieDev.minierp.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
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
        List<User> users = userMapper.getUserBirthday(previousDate,lastDayOfNextMonth,currentDate);
        List<ScheduleListResponse.TaskResponse> list = taskConverter.toListTaskResponseOfSchedule(tasks,users,firstDayOfMonth);
        IdAndFullnameUserResponse user = userService.findIdAndFullNameOfUser(userId);
        return new ScheduleListResponse(list, user);
    }
}

