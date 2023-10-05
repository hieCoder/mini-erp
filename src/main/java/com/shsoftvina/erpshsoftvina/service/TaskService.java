package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.task.TaskRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskResponse;
import com.shsoftvina.erpshsoftvina.model.response.timesheets.TimesheetsResponse;

import java.util.List;

public interface TaskService {
    List<TaskResponse> findAll(int start, int pageSize, String status, String search);
    int registerTask(TaskRegisterRequest taskRegisterRequest);
}
