package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.PageWeeklyReportListRespone;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.TaskService;
import com.shsoftvina.erpshsoftvina.service.WeeklyReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/v1/weekly-reports")
public class WeeklyReportApi {

    @Autowired
    WeeklyReportService weeklyReportService;

    @Autowired
    TaskService taskService;

    @GetMapping
    public ResponseEntity<?> getAllWeeklyReport(@RequestParam(name = "search", required = false, defaultValue = "") String search,
                                                @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                                @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize) {
        User user = Principal.getUserCurrent();
        PageWeeklyReportListRespone weeklyReports = weeklyReportService.getAllWeeklyReport(search, user.getRole().getValue(), user.getId(), page, pageSize);


        return new ResponseEntity<>(weeklyReports, HttpStatus.OK);
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
