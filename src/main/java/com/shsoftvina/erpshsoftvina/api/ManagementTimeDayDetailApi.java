package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailUpdateRequest;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/management-time-detail")
public class ManagementTimeDayDetailApi {

    @Autowired
    ManagementTimeDayDetailService managementTimeDayDetailService;

    @GetMapping("/{id}")
    public ResponseEntity<?> findByid(@PathVariable("id") String id,@RequestParam("code") String code) {
        return ResponseEntity.ok(managementTimeDayDetailService.findById(id, code));
    }

    @PostMapping
    public ResponseEntity<?> createDay(@RequestBody DayDetailCreateRequest dayDetailCreateRequest) {
        return ResponseEntity.ok(managementTimeDayDetailService.createTimeDayDetail(dayDetailCreateRequest));
    }

    @PutMapping
    public ResponseEntity<?> updateDay(@RequestBody DayDetailUpdateRequest dayDetailUpdateRequest) {
        System.out.println(dayDetailUpdateRequest);
        return ResponseEntity.ok(managementTimeDayDetailService.updateTimeDayDetail(dayDetailUpdateRequest));
    }
}
