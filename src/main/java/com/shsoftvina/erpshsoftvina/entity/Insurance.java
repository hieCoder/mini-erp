package com.shsoftvina.erpshsoftvina.entity;

import com.shsoftvina.erpshsoftvina.enums.insurance.InsuranceType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Insurance {

    private String id;
    private InsuranceType insuranceType;
    private String money;
}