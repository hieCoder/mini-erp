package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.enums.contract.InsuranceTypeEnum;
import com.shsoftvina.erpshsoftvina.enums.contract.StatusContractEnum;
import com.shsoftvina.erpshsoftvina.mapper.ContractMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.contract.CreateContractRequest;
import com.shsoftvina.erpshsoftvina.model.request.contract.UpdateContractRequest;
import com.shsoftvina.erpshsoftvina.model.response.contract.ContractResponse;
import com.shsoftvina.erpshsoftvina.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class ContractConverter {

    @Autowired
    private ContractMapper contractMapper;

    @Autowired
    private UserMapper userMapper;

    public Contract toEntity(CreateContractRequest createContractRequest, String contractFileName){
        String parentContractId = createContractRequest.getParentId();

        Contract contract = null;

        if (!StringUtils.isBlank(parentContractId)) contract = contractMapper.findById(createContractRequest.getParentId());

        return Contract.builder()
                .id(ApplicationUtils.generateId())
                .basicSalary(createContractRequest.getBasicSalary())
                .allowance(createContractRequest.getAllowance())
                .files(contractFileName)
                .createdDate(new Date())
                .user(userMapper.findById(createContractRequest.getUserId()))
                .insurance(createContractRequest.getInsurance())
                .parentContract(contract)
                .status(StatusContractEnum.ACTIVE).build();
    }

    public ContractResponse toResponse(Contract contract){

        if (contract == null) return null;

        return ContractResponse.builder()
                .id(contract.getId())
                .basicSalary(contract.getBasicSalary())
                .allowance(contract.getAllowance())
                .insurance((contract.getInsurance()))
                .files(FileUtils.getPathUpload(Contract.class, contract.getFiles()))
                .createdDate(DateUtils.formatDateTime(contract.getCreatedDate()))
                .historyContract(toListResponseHistory(contract.getHistoryContract()))
                .build();
    }

    public List<ContractResponse> toListResponse(List<Contract> contracts) {
        return contracts.stream().map(this::toResponse).collect(Collectors.toList());
    }
    public List<ContractResponse> toListResponseHistory(List<Contract> contracts) {
        if(contracts == null) return null;
        return contracts.stream().map(c -> toResponse(c)).collect(Collectors.toList());
    }

    public Contract toEntity(UpdateContractRequest updateContractRequest, String contractFileName){
        return Contract.builder()
                .id(updateContractRequest.getId())
                .basicSalary(updateContractRequest.getBasicSalary())
                .allowance(updateContractRequest.getAllowance())
                .files(contractFileName)
                .insurance(updateContractRequest.getInsurance())
                .build();
    }
}