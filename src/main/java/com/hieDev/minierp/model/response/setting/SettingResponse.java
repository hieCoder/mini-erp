package com.hieDev.minierp.model.response.setting;
import com.hieDev.minierp.model.dto.EnumDto;
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
