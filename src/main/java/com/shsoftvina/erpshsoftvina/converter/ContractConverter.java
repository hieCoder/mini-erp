package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.entity.Insurance;
import com.shsoftvina.erpshsoftvina.model.response.contract.ContractResponse;
import com.shsoftvina.erpshsoftvina.model.response.insurance.InsuranceResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class ContractConverter {

    @Autowired
    private InsuranceConverter insuranceConverter;

    public List<ContractResponse> toListResponse(List<Contract> contracts) {
        return contracts.stream().map(contract -> ContractResponse.builder()
                .id(contract.getId())
                .basicSalary(contract.getBasicSalary())
                .allowance(contract.getAllowance())
                .insurance(insuranceConverter.toResponse(contract.getInsurance()))
                .contract(contract.getContract())
                .createdDate(DateUtils.formatDate(contract.getCreatedDate())).build()).collect(Collectors.toList());
    }
}