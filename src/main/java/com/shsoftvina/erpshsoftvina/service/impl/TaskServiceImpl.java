package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.TaskConverter;
import com.shsoftvina.erpshsoftvina.converter.TimesheetsConverter;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.TimesheetsMapper;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskResponse;
import com.shsoftvina.erpshsoftvina.model.response.timesheets.TimesheetsResponse;
import com.shsoftvina.erpshsoftvina.service.TaskService;
import com.shsoftvina.erpshsoftvina.service.TimesheetsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TaskServiceImpl implements TaskService {

    @Autowired
    TaskMapper taskMapper;

    @Autowired
    TaskConverter taskConverter;

    @Override
    public List<TaskResponse> findAll(int start, int pageSize, String status, String search) {
        return taskMapper.findAll(start, pageSize, status, search).stream().map(task -> taskConverter.toResponse(task)).collect(Collectors.toList());
    }

    @Override
    public int registerTask(TaskRegisterRequest taskRegisterRequest) {
        try{
            taskMapper.registerTask(taskConverter.toEntity(taskRegisterRequest));
            return 1;
        } catch (Exception e){}
        return 0;
    }
}
