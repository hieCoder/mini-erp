package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;

import java.util.List;
import java.util.Map;

public interface ScheduleService {
    List<Map<String, Object>> getAllFullname();
    List<TaskShowResponse> getScheduleDetail(String userId);
}
