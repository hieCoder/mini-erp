package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.task.TaskRegisterRequest;
import com.hieDev.minierp.model.request.task.TaskUpdateRequest;
import com.hieDev.minierp.model.response.task.DashboardTaskResponse;
import com.hieDev.minierp.model.response.task.StatusTaskCountsResponse;
import com.hieDev.minierp.model.response.task.TaskDetailResponse;
import com.hieDev.minierp.model.response.task.TaskShowResponse;

import java.util.List;
import java.util.Map;

public interface TaskService {
    List<TaskShowResponse> findAll(int start, int pageSize, String statusTask, String picSearch, String tagSearch, String titleSearch);
    long getTotalItem(String statusTask,String picSearch, String tagSearch, String titleSearch);
    int registerTask(TaskRegisterRequest taskRegisterRequest);
    int updateTask(TaskUpdateRequest taskUpdateRequest);
    int deleteById(String id);
    List<StatusTaskCountsResponse> getStatusTaskCount();
    TaskDetailResponse findById(String id);
    List<Map<String, Object>> getTaskByTitle(String userId, String title);
    List<Map<String, Object>> findAllTitle();
    int deleteByIds(String[] ids);

    DashboardTaskResponse getOpenedTask(String userId);
}
