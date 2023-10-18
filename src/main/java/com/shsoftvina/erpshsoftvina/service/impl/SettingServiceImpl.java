package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.SettingConverter;
import com.shsoftvina.erpshsoftvina.entity.Setting;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.SettingMapper;
import com.shsoftvina.erpshsoftvina.model.request.setting.SettingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.setting.SettingResponse;
import com.shsoftvina.erpshsoftvina.service.SettingService;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SettingServiceImpl implements SettingService {

    @Autowired
    private SettingMapper settingMapper;

    @Autowired
    private SettingConverter settingConverter;

    @Override
    public List<SettingResponse> findAll() {
        return settingMapper.findAll().stream().map(setting -> settingConverter.toResponse(setting)).collect(Collectors.toList());
    }

    @Override
    public SettingResponse findById(String id) {
        return settingConverter.toResponse(settingMapper.findById(id));
    }

    @Override
    public int updateSetting(SettingUpdateRequest[] settingUpdateRequests) {

        int updatedCount = 0;

        for (SettingUpdateRequest settingUpdateRequest : settingUpdateRequests) {
            if (settingMapper.findByCode(settingUpdateRequest.getCode()) == null)
                throw new NotFoundException(MessageErrorUtils.notFound("code"));

            Setting setting = settingConverter.toEntity(settingUpdateRequest);
            try {
                int result = settingMapper.updateSetting(setting);
                if (result > 0) {
                    updatedCount++;
                }
            } catch (Exception e) {
            }
        }

        return updatedCount;
    }
}
