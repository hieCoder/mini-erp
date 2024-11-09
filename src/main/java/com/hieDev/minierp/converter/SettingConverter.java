package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.Setting;
import com.hieDev.minierp.enums.setting.CodeSettingEnum;
import com.hieDev.minierp.model.request.setting.SettingUpdateRequest;
import com.hieDev.minierp.model.response.setting.SettingResponse;
import com.hieDev.minierp.utils.EnumUtils;
import org.springframework.stereotype.Component;

@Component
public class SettingConverter {

    public SettingResponse toResponse(Setting setting) {
        return SettingResponse.builder()
                .id(setting.getId())
                .code(EnumUtils.instance(setting.getCode()))
                .imageType(setting.getImageType())
                .fileType(setting.getFileType())
                .fileLimit(setting.getFileLimit())
                .fileSize(setting.getFileSize()).build();
    }

    public Setting toEntity(SettingUpdateRequest settingUpdateRequest) {
        return Setting.builder()
                .code(EnumUtils.getEnumFromValue(CodeSettingEnum.class, settingUpdateRequest.getCode()))
                .imageType(settingUpdateRequest.getImageType())
                .fileType(settingUpdateRequest.getFileType())
                .fileLimit(settingUpdateRequest.getFileLimit())
                .fileSize(settingUpdateRequest.getFileSize()).build();
    }
}