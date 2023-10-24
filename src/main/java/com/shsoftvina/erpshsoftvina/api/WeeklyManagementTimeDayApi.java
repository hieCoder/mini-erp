package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.weekly.WeeklyManagementTimeDayUpdateRequest;
import com.shsoftvina.erpshsoftvina.service.WeeklyManagementTimeDayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/weekly-management-time-day")
public class WeeklyManagementTimeDayApi {

    @Autowired
    private WeeklyManagementTimeDayService weeklyManagementTimeDayService;

    @PutMapping
    public ResponseEntity<?> updateWeekly(@RequestBody WeeklyManagementTimeDayUpdateRequest weeklyManagementTimeDayUpdateRequest) {
        return ResponseEntity.ok(weeklyManagementTimeDayService.updateWeekly(weeklyManagementTimeDayUpdateRequest));
    }
}
