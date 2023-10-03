package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Insurance;
import com.shsoftvina.erpshsoftvina.model.response.insurance.InsuranceResponse;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import org.springframework.stereotype.Component;

@Component
public class InsuranceConverter {
    public InsuranceResponse toResponse(Insurance insurance) {
        return InsuranceResponse.builder()
                .id(insurance.getId())
                .insuranceType(EnumUtils.instance(insurance.getInsuranceType()))
                .money(insurance.getMoney()).build();
    }
}