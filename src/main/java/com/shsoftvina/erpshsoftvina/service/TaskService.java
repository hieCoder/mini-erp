package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.task.TaskRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.response.task.StatusTaskCountsResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;

import java.util.List;

public interface TaskService {
    List<TaskShowResponse> findAll(int start, int pageSize, String status, String search);
    int registerTask(TaskRegisterRequest taskRegisterRequest);
    List<StatusTaskCountsResponse> getStatusTaskCount();
    TaskDetailResponse findById(String id);
}
