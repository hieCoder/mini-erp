package com.shsoftvina.erpshsoftvina.entity;

import com.shsoftvina.erpshsoftvina.enums.allowance_insurance.AllowanceInsuranceType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AllowanceInsurance {
    private String id;
    private String item;
    private Integer itemValue;
    private Contract contract;
    private AllowanceInsuranceType type;
}