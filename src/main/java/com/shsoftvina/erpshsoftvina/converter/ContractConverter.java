package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.enums.contract.InsuranceTypeEnum;
import com.shsoftvina.erpshsoftvina.enums.contract.StatusContractEnum;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.contract.CreateContractRequest;
import com.shsoftvina.erpshsoftvina.model.request.contract.UpdateContractRequest;
import com.shsoftvina.erpshsoftvina.model.response.contract.ContractResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class ContractConverter {

    @Autowired
    private UserMapper userMapper;

    public Contract toEntity(CreateContractRequest createContractRequest, String contractFileName){
        return Contract.builder()
                .id(UUID.randomUUID().toString())
                .basicSalary(createContractRequest.getBasicSalary())
                .allowance(createContractRequest.getAllowance())
                .contract(contractFileName)
                .createdDate(new Date())
                .user(userMapper.findById(createContractRequest.getUserId()))
                .insuranceMoney(createContractRequest.getInsuranceMoney())
                .insuranceType(EnumUtils.getEnumFromValue(InsuranceTypeEnum.class, createContractRequest.getInsuranceType()))
                .status(StatusContractEnum.ACTIVE).build();
    }

    public ContractResponse toResponse(Contract contract){
        return ContractResponse.builder()
                .id(contract.getId())
                .basicSalary(contract.getBasicSalary())
                .allowance(contract.getAllowance())
                .insuranceType(EnumUtils.instance(contract.getInsuranceType()))
                .insuranceMoney(contract.getInsuranceMoney())
                .contract(FileUtils.getPathUpload(Contract.class, contract.getContract()))
                .createdDate(DateUtils.formatDate(contract.getCreatedDate())).build();
    }

    public List<ContractResponse> toListResponse(List<Contract> contracts) {
        return contracts.stream().map(this::toResponse).collect(Collectors.toList());
    }

    public Contract toEntity(UpdateContractRequest updateContractRequest, String contractFileName){
        return Contract.builder()
                .id(updateContractRequest.getId())
                .basicSalary(updateContractRequest.getBasicSalary())
                .allowance(updateContractRequest.getAllowance())
                .contract(contractFileName)
                .insuranceMoney(updateContractRequest.getInsuranceMoney())
                .insuranceType(EnumUtils.getEnumFromValue(
                        InsuranceTypeEnum.class, updateContractRequest.getInsuranceType())).build();
    }
}