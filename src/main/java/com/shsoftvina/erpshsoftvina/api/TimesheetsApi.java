package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.service.TimesheetsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
}
