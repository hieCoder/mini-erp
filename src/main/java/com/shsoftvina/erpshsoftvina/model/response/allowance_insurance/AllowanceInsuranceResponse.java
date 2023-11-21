package com.shsoftvina.erpshsoftvina.model.response.allowance_insurance;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AllowanceInsuranceResponse {
    private String id;
    private String item;
    private Integer itemValue;
    private String type;
}