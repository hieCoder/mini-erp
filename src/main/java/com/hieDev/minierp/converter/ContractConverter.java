package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.Contract;
import com.hieDev.minierp.enums.contract.StatusContractEnum;
import com.hieDev.minierp.mapper.ContractMapper;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.request.contract.CreateContractRequest;
import com.hieDev.minierp.model.request.contract.UpdateContractRequest;
import com.hieDev.minierp.model.response.contract.ContractResponse;
import com.hieDev.minierp.utils.DateUtils;
import com.hieDev.minierp.utils.FileUtils;
import com.hieDev.minierp.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class ContractConverter {

    @Autowired
    private ContractMapper contractMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private AllowanceInsuranceConverter allowanceInsuranceConverter;

    public Contract toEntity(CreateContractRequest createContractRequest, String contractFileName){
        String parentContractId = createContractRequest.getParentId();
        Contract contract = null;
        if (!StringUtils.isBlank(parentContractId)) contract = contractMapper.findById(parentContractId);

        return Contract.builder()
                .id(UUID.randomUUID().toString())
                .basicSalary(createContractRequest.getBasicSalary())
                .files(contractFileName)
                .createdDate(new Date())
                .user(userMapper.findById(createContractRequest.getUserId()))
                .parentContract(contract)
                .status(StatusContractEnum.ACTIVE).build();
    }

    public ContractResponse toResponse(Contract contract){

        if (contract == null) return null;

        return ContractResponse.builder()
                .id(contract.getId())
                .basicSalary(contract.getBasicSalary())
                .files(FileUtils.getPathUpload(Contract.class, contract.getFiles()))
                .createdDate(DateUtils.formatDateTime(contract.getCreatedDate()))
                .allowanceInsurances(allowanceInsuranceConverter.toListAllowanceResponse(contract.getAllowanceInsurances()))
                .build();
    }

    public List<ContractResponse> toListResponse(List<Contract> contracts) {
        if(contracts == null) return null;
        return contracts.stream().map(this::toResponse).collect(Collectors.toList());
    }

    public Contract toEntity(UpdateContractRequest updateContractRequest, String contractFileName){
        return Contract.builder()
                .id(updateContractRequest.getId())
                .basicSalary(updateContractRequest.getBasicSalary())
                .files(contractFileName)
                .build();
    }
}