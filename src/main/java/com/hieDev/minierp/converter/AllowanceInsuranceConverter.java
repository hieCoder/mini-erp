package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.AllowanceInsurance;
import com.hieDev.minierp.model.response.allowance_insurance.AllowanceInsuranceResponse;
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
