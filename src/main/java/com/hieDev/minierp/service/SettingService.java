package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.setting.SettingUpdateRequest;
import com.hieDev.minierp.model.response.setting.SettingResponse;

import java.util.List;

public interface SettingService {
    List<SettingResponse> findAll();
    SettingResponse findById(String id);
    int updateSetting(SettingUpdateRequest[] settingUpdateRequests);
    SettingResponse findByCode(String code);
}