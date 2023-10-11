package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Setting;
import com.shsoftvina.erpshsoftvina.model.request.setting.SettingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.setting.SettingResponse;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import org.springframework.stereotype.Component;

@Component
public class SettingConverter {

    public SettingResponse toResponse(Setting setting) {
        return SettingResponse.builder()
                .id(setting.getId())
                .code(EnumUtils.instance(setting.getCode()))
                .imageType(setting.getImageType())
                .fileType(setting.getFileType())
                .fileSize(setting.getFileSize()).build();
    }

    public Setting toEntity(SettingUpdateRequest settingUpdateRequest) {
        return Setting.builder()
                .id(settingUpdateRequest.getId())
                .imageType(settingUpdateRequest.getImageType())
                .fileType(settingUpdateRequest.getFileType())
                .fileSize(settingUpdateRequest.getFileSize()).build();
    }
}