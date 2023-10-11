package com.shsoftvina.erpshsoftvina.api;


import com.shsoftvina.erpshsoftvina.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/schedules")
public class ScheduleApi {

    @Autowired
    private ScheduleService scheduleService;

    @GetMapping
    public ResponseEntity<?> getAllFullname() {
        return new ResponseEntity<>(scheduleService.getAllFullname(), HttpStatus.OK);
    }

    @GetMapping("/{userId}")
    public ResponseEntity<?> getScheduleDetail(@PathVariable String userId) {
        return new ResponseEntity<>(scheduleService.getScheduleDetail(userId), HttpStatus.OK);
    }
}
