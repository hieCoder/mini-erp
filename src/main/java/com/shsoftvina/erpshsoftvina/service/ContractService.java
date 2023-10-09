package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.model.request.contract.CreateContractRequest;
import com.shsoftvina.erpshsoftvina.model.request.contract.UpdateContractRequest;
import com.shsoftvina.erpshsoftvina.model.response.contract.ContractResponse;

public interface ContractService {
    int addContract(CreateContractRequest createContractRequest);
    ContractResponse findById(String id);
    int updateContract(UpdateContractRequest updateContractRequest);
    int deleteContract(String id);
}