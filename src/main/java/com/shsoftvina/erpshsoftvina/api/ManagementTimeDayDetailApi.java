package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailCreateRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/management-time-detail")
public class ManagementTimeDayDetailApi {

    @PostMapping("/day")
    public ResponseEntity<?> createDay(@RequestBody DayDetailCreateRequest dayDetailCreateRequest) {
        return ResponseEntity.ok(null);
    }
}
