package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.UpdateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.service.TaskService;
import com.shsoftvina.erpshsoftvina.service.WeeklyReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/weekly-reports")
public class WeeklyReportApi {

    @Autowired
    WeeklyReportService weeklyReportService;

    @Autowired
    TaskService taskService;

    @GetMapping
    public ResponseEntity<?> getAllWeeklyReport(@RequestParam(name = "userRole") String userRole,
                                                @RequestParam(name = "userId") String userId,
                                                @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                                @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize) {
        return ResponseEntity.ok(weeklyReportService.getAllWeeklyReport(userRole, userId, page, pageSize));
    }

    @GetMapping("/count")
    public ResponseEntity<?> getTotalWeeklyReport(@RequestParam(name = "userRole") String userRole,
                                                @RequestParam(name = "userId") String userId,
                                                @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                                @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize) {
        return ResponseEntity.ok(weeklyReportService.getTotalWeeklyReport(userRole, userId, page, pageSize));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getDetail(@PathVariable("id") String id) {
        return ResponseEntity.ok(weeklyReportService.findById(id));
    }

    @PostMapping
    public ResponseEntity<?> createWeeklyReport(@Valid @RequestBody CreateWeeklyReportRequest createWeeklyReportRequest) {
        return ResponseEntity.ok(weeklyReportService.createWeeklyReport(createWeeklyReportRequest));
    }

    @PutMapping
    public ResponseEntity<?> updateWeeklyReport(@Valid @RequestBody UpdateWeeklyReportRequest updateWeeklyReportRequest) {
        return ResponseEntity.ok(weeklyReportService.updateWeeklyReport(updateWeeklyReportRequest));
    }
}
