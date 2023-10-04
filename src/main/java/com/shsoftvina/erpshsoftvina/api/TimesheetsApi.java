package com.shsoftvina.erpshsoftvina.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shsoftvina.erpshsoftvina.service.TimesheetsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/timesheets")
public class TimesheetsApi {

    @Autowired
    TimesheetsService timesheetsService;

    @GetMapping
    public ResponseEntity<?> findAll(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                     @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize
    ) {
        return ResponseEntity.ok(timesheetsService.findAll((page - 1) * pageSize, pageSize));
    }

    @GetMapping("/{userID}")
    public ResponseEntity<?> getWorkDateByYear(@PathVariable("userID") String userID,
                                               @RequestParam(name = "year", required = false) String year) {
        List<Map<String, ?>> workDates = null;
        if (year!=null)  workDates = timesheetsService.totalWorkDateByMonth(userID, year);
        else workDates = timesheetsService.totalWorkDateByYear(userID);

        return new ResponseEntity<>(workDates, HttpStatus.OK);
    }

}
