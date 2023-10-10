package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.setting.SettingUpdateRequest;
import com.shsoftvina.erpshsoftvina.service.SettingService;
import com.shsoftvina.erpshsoftvina.service.TimesheetsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/settings")
public class SettingApi {

    @Autowired
    private SettingService settingService;

    @GetMapping
    public ResponseEntity<?> findAll() {
        return ResponseEntity.ok(settingService.findAll());
    }

    @GetMapping("{id}")
    public ResponseEntity<?> findById(@PathVariable("id") String id) {
        return ResponseEntity.ok(settingService.findById(id));
    }

    @PutMapping
    public ResponseEntity<?> updateSetting(@Valid @RequestBody SettingUpdateRequest settingUpdateRequest) {
        return ResponseEntity.ok(settingService.updateSetting(settingUpdateRequest));
    }
}
