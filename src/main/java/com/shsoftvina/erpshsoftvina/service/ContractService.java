package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.contract.CreateContractRequest;
import com.shsoftvina.erpshsoftvina.model.request.contract.UpdateContractRequest;
import com.shsoftvina.erpshsoftvina.model.response.contract.ContractResponse;

import java.util.List;

public interface ContractService {
    ContractResponse addContract(CreateContractRequest createContractRequest);
    ContractResponse findById(String id);
    int updateContract(UpdateContractRequest updateContractRequest);
    int deleteContract(String id);
    List<ContractResponse> getContractByUser(String userId);
}