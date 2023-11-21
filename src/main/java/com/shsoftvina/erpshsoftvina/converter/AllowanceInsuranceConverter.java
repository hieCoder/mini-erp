package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.AllowanceInsurance;
import com.shsoftvina.erpshsoftvina.model.response.allowance_insurance.AllowanceInsuranceResponse;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class AllowanceInsuranceConverter {

    public AllowanceInsuranceResponse toResponse(AllowanceInsurance allowanceInsurance){
        if(allowanceInsurance == null) return null;
        return AllowanceInsuranceResponse.builder()
                .id(allowanceInsurance.getId())
                .item(allowanceInsurance.getItem())
                .itemValue(allowanceInsurance.getItemValue())
                .type(allowanceInsurance.getType().toString())
                .build();
    }

    public List<AllowanceInsuranceResponse> toListAllowanceResponse(List<AllowanceInsurance> allowanceInsurances){
        if(allowanceInsurances == null) return null;
        return allowanceInsurances.stream().map(this::toResponse).collect(Collectors.toList());
    }
}
