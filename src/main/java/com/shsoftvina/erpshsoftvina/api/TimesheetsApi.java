package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.service.TimesheetsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/timesheets")
public class TimesheetsApi {

    @Autowired
    TimesheetsService timesheetsService;

    @GetMapping
    public ResponseEntity<?> findAll(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                     @RequestParam(name = "pageSize", required = false, defaultValue = "50") int pageSize
    ) {
        return ResponseEntity.ok(timesheetsService.findAll((page - 1) * pageSize, pageSize));
    }

    @GetMapping("/workingday/{userID}")
    public ResponseEntity<?> getTotalWorkingDate(@PathVariable("userID") String userID,
                                               @RequestParam(name = "year", required = false) String year) {

        List<Map<String, ?>> workingDay = null;
        if (year == null)  workingDay = timesheetsService.getTotalWorkDayByYear(userID);
        else workingDay = timesheetsService.getTotalWorkDayByMonth(userID, year);

        return ResponseEntity.ok(workingDay);
    }

}
