package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Allowance;
import com.shsoftvina.erpshsoftvina.model.response.allowance.AllowanceResponse;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class AllowanceConverter {

    public AllowanceResponse toResponse(Allowance allowance){
        if(allowance == null) return null;
        return AllowanceResponse.builder()
                .id(allowance.getId())
                .item(allowance.getItem())
                .itemValue(allowance.getItemValue()).build();
    }

    public List<AllowanceResponse> toListAllowanceResponse(List<Allowance> allowances){
        if(allowances == null) return null;
        return allowances.stream().map(this::toResponse).collect(Collectors.toList());
    }
}
