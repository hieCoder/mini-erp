package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar.CalendarUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayUpdateRequest;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/management-time")
public class ManagementTimeDayApi {

    @Autowired
    private ManagementTimeDayService managementTimeDayService;

    @PostMapping("/calendar")
    public ResponseEntity<?> updateCalendar(@RequestBody CalendarUpdateRequest req) {
        return ResponseEntity.ok(managementTimeDayService.updateCalendar(req));
    }

    @GetMapping("/calendar/{userId}")
    public ResponseEntity<?> showCalendar(@RequestParam String endDate,
                                     @RequestParam String startDate,
                                     @PathVariable String userId) {
        return ResponseEntity.ok(managementTimeDayService.showCalendar(userId, startDate, endDate));
    }

    @GetMapping("/weekly-detail/{userId}")
    public ResponseEntity<?> showListDayOfWeek(@PathVariable String userId, @RequestParam String currentDay) {
        return ResponseEntity.ok(managementTimeDayService.showListDayOfWeek(userId, currentDay));
    }

//    @PostMapping("/day")
//    public ResponseEntity<?> createDay(@RequestBody DayCreateRequest dayCreateRequest) {
//        return ResponseEntity.ok(managementTimeDayService.createDay(dayCreateRequest));
//    }
//
//    @PutMapping("/day")
//    public ResponseEntity<?> updateDay(@RequestBody DayUpdateRequest updateRequest) {
//        return ResponseEntity.ok(managementTimeDayService.updateDay(updateRequest));
//    }
//
//    @GetMapping("/day/{id}")
//    public ResponseEntity<?> getDay(@PathVariable String id) {
//        return ResponseEntity.ok(managementTimeDayService.findById(id));
//    }
}