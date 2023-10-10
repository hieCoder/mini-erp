package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.setting.SettingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.setting.SettingResponse;

import java.util.List;

public interface SettingService {
    List<SettingResponse> findAll();
    SettingResponse findById(String id);
    int updateSetting(SettingUpdateRequest settingUpdateRequest);
}