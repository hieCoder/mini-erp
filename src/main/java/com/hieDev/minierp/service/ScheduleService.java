package com.hieDev.minierp.service;

import com.hieDev.minierp.model.response.schedule.ScheduleListResponse;

public interface ScheduleService {
    ScheduleListResponse getScheduleDetail(String userId, String monthly);
}