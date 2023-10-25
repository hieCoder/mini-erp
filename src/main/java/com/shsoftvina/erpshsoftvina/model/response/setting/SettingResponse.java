package com.shsoftvina.erpshsoftvina.model.response.setting;
import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SettingResponse {

    private String id;
    private EnumDto code;
    private String imageType;
    private String fileType;
    private Integer fileLimit;
    private Integer fileSize;
}
