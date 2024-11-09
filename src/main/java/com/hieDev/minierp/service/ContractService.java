package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.contract.CreateContractRequest;
import com.hieDev.minierp.model.request.contract.UpdateContractRequest;
import com.hieDev.minierp.model.response.contract.ContractResponse;

import java.util.List;

public interface ContractService {
    ContractResponse addContract(CreateContractRequest createContractRequest);
    ContractResponse findById(String id);
    int updateContract(UpdateContractRequest updateContractRequest);
    int deleteContract(String id);
    List<ContractResponse> getHistoryContract(String id);
}