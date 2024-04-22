package com.shsoftvina.erpshsoftvina.model.response.tag;

import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TagResponse {

    private String id;
    private String tagName;
    private EnumDto type;

}
