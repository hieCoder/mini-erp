package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/management-time")
public class ManagementTimeDayApi {

    @Autowired
    private ManagementTimeDayService managementTimeDayService;

    @PostMapping("/day")
    public ResponseEntity<?> createDay(@RequestBody String jsonDay) {
        return ResponseEntity.ok(managementTimeDayService.createDay(jsonDay));
    }

    @PutMapping("/day")
    public ResponseEntity<?> updateDay(@RequestBody String jsonDay) {
        return ResponseEntity.ok(managementTimeDayService.updateDay(jsonDay));
    }

    @GetMapping("/day/{id}")
    public ResponseEntity<?> getDay(@PathVariable String id) {
        return ResponseEntity.ok(managementTimeDayService.findById(id));
    }

    @GetMapping("/{userId}")
    public ResponseEntity<?> getDaysByMonthAndYear(@RequestParam String month,
                                                   @RequestParam String year,
                                                   @PathVariable String userId) {
        return ResponseEntity.ok(managementTimeDayService.findAllByMonthYear(userId, month, year));
    }
}