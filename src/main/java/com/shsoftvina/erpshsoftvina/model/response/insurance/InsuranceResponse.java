package com.shsoftvina.erpshsoftvina.model.response.insurance;

import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class InsuranceResponse {
    private String id;
    private EnumDto type;
    private String money;
}