package com.shsoftvina.erpshsoftvina.model.response.setting;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SettingAllowanceResponse {
    private String maxFileSize;
    private String listTypeFile;
    private Integer uploadFileLimit;
}
