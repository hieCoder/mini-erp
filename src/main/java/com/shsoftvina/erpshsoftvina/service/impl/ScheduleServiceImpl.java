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
    public ScheduleListResponse getScheduleDetail(String userId, Date startDate, Date endDate) {

        if (startDate != null && endDate != null){
            if (startDate.compareTo(endDate) > 0){
                throw new InvalidException(MessageErrorUtils.invalid());
            }
        }
        List<User> users = new ArrayList<>();
        List<Task> tasks = scheduleMapper.getScheduleDetail(userId, startDate, endDate);
        List<ScheduleListResponse.TaskResponse> list = taskConverter.toListTaskResponseOfSchedule(tasks,users);
        IdAndFullnameUserResponse user = userService.findIdAndFullNameOfUser(userId);
        applicationUtils.checkUserAllow(userId);
        return new ScheduleListResponse(list, user);
    }

    @Override
    public ScheduleListResponse getScheduleDetail(String userId, String monthly) {
        List<Task> tasks = scheduleMapper.getScheduleDetailByMonth(userId, monthly);
        String firstDayOfMonth = monthly + "-01";
        List<User> users = userMapper.getUserBirthday(firstDayOfMonth);
        List<ScheduleListResponse.TaskResponse> list = taskConverter.toListTaskResponseOfSchedule(tasks,users);
        IdAndFullnameUserResponse user = userService.findIdAndFullNameOfUser(userId);
        applicationUtils.checkUserAllow(userId);
        return new ScheduleListResponse(list, user);
    }
}

