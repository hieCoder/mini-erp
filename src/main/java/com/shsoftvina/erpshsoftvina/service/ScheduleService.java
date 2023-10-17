package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.response.schedule.ScheduleListResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;

import java.util.Date;
import java.util.List;

public interface ScheduleService {
    ScheduleListResponse getScheduleDetail(String userId, Date startDate, Date endDate);
}