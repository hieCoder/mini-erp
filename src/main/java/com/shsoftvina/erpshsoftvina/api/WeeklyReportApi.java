package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.service.WeeklyReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/weeklyReports")
public class WeeklyReportApi {

    @Autowired
    WeeklyReportService weeklyReportService;

    @GetMapping
    public ResponseEntity<?> getAll(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                    @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize,
                                    @RequestParam(name = "search", required = false, defaultValue = "") String search) {
        return ResponseEntity.ok(weeklyReportService.getAllWeeklyReport((page-  1) * pageSize, pageSize, search));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getDetail(@PathVariable("id") String id) {
        return ResponseEntity.ok(weeklyReportService.findById(id));
    }

    @PostMapping
    public ResponseEntity<?> createWeeklyReport(@Valid @RequestBody CreateWeeklyReportRequest createWeeklyReportRequest) {
        return ResponseEntity.ok(weeklyReportService.createWeeklyReport(createWeeklyReportRequest));
    }
}
