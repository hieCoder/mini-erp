package com.hieDev.minierp.entity;

import com.hieDev.minierp.enums.setting.CodeSettingEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

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
