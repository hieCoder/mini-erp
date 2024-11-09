package com.hieDev.minierp.model.request.allowance_insurance;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AllowanceInsuranceRequest {
    private String item;
    private Integer itemValue;
    private String type;
}
