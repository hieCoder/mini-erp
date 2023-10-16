package com.shsoftvina.erpshsoftvina.api;


import com.shsoftvina.erpshsoftvina.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Date;

@RestController
@RequestMapping("/api/v1/schedules")
public class ScheduleApi {

    @Autowired
    private ScheduleService scheduleService;

    @GetMapping("/{userId}")
    public ResponseEntity<?> getScheduleDetail(@PathVariable String userId,
                                               @RequestParam(required = false) Date startDate,
                                               @RequestParam(required = false) Date endDate) {
        return new ResponseEntity<>(scheduleService.getScheduleDetail(userId, startDate, endDate), HttpStatus.OK);
    }
}