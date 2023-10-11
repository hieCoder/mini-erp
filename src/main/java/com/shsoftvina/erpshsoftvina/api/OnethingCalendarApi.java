package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.service.OCAndTLService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/onething-calendar")
public class OnethingCalendarApi {

    @Autowired
    private OCAndTLService OCAndTLService;

    @GetMapping("/{userId}")
    public ResponseEntity<?> findById(@PathVariable("userId") String userId) {
        return ResponseEntity.ok(OCAndTLService.getAllByUserId(userId));
    }
}
