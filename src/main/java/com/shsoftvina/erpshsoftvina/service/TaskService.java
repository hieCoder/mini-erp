package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.task.TaskRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.task.StatusTaskCountsResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TaskService {
    List<TaskShowResponse> findAll(int start, int pageSize, String status, String search);
    int registerTask(TaskRegisterRequest taskRegisterRequest);
    int updateTask(TaskUpdateRequest taskUpdateRequest);
    int deleteById(String id);
    List<StatusTaskCountsResponse> getStatusTaskCount();
    TaskDetailResponse findById(String id);
    List<Map<String, Object>> getTaskByHashtag(String userId, String hashtag);
}