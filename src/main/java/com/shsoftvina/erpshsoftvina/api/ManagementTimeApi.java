package com.shsoftvina.erpshsoftvina.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.DayDto;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/management-time")
public class ManagementTimeApi {

    @Autowired
    private ManagementTimeService managementTimeService;

    @PostMapping("/day")
    public ResponseEntity<?> createDay(@RequestBody String jsonDay) {
        return ResponseEntity.ok(managementTimeService.updateDay(jsonDay));
    }
}