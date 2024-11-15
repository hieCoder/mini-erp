package com.hieDev.minierp.api;

import com.hieDev.minierp.model.request.managementtime.calendar.CalendarUpdateRequest;
import com.hieDev.minierp.model.request.managementtime.day.DaysUpdateRequest;
import com.hieDev.minierp.model.request.managementtime.day.SpendingMonthRequest;
import com.hieDev.minierp.service.ManagementTimeDayService;
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

    @PostMapping("/weekly-detail")
    public ResponseEntity<?> updateListDayOfWeek(@RequestBody DaysUpdateRequest daysUpdateRequest) {
        return ResponseEntity.ok(managementTimeDayService.updateListDayOfWeek(daysUpdateRequest));
    }

    @PostMapping("/weekly-detail/spending")
    public ResponseEntity<?> handleSpendingMonth(@RequestBody SpendingMonthRequest req) {
        return ResponseEntity.ok(managementTimeDayService.updateSpendingMonth(req));
    }

    @GetMapping("/weekly-detail/spending/{userId}")
    public ResponseEntity<?> getSpendingMonth(@PathVariable String userId, @RequestParam String monthCode) {
        return ResponseEntity.ok(managementTimeDayService.showSpendingMonth(userId, monthCode));
    }

    @GetMapping("/weekly-detail/monthOfYear/{userId}")
    public ResponseEntity<?> allMonthOfYear(@PathVariable String userId, @RequestParam String year) {
        return ResponseEntity.ok(managementTimeDayService.monthOfYear(userId, year));
    }
}