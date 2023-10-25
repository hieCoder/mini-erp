package com.shsoftvina.erpshsoftvina.entity;

import com.shsoftvina.erpshsoftvina.enums.setting.CodeSettingEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Setting {

    private String id;
    private CodeSettingEnum code;
    private String imageType;
    private String fileType;
    private Integer fileLimit;
    private Integer fileSize;
}
