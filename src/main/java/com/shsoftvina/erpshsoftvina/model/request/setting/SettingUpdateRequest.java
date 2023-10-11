package com.shsoftvina.erpshsoftvina.model.request.setting;

import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SettingUpdateRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    @NotBlank(message = "Field imageType is not filled")
    private String imageType;

    @NotBlank(message = "Field fileType is not filled")
    private String fileType;

    @Min(value = 1, message = "Field fileSize must > 1")
    private Integer fileSize;
}