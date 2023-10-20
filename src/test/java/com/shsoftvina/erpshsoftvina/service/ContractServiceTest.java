package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.contract.StatusContractEnum;
import com.shsoftvina.erpshsoftvina.mapper.ContractMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.contract.CreateContractRequest;
import com.shsoftvina.erpshsoftvina.model.request.contract.UpdateContractRequest;
import com.shsoftvina.erpshsoftvina.service.impl.ContractServiceImpl;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.web.multipart.MultipartFile;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class ContractServiceTest {
    @InjectMocks
    private ContractServiceImpl contractService;

    @Mock
    private ContractMapper contractMapper;

    @Mock
    private UserMapper userMapper;

    @Mock
    private ApplicationUtils applicationUtils;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

//    @Test
//    public void testAddContract() {
//        CreateContractRequest createContractRequest = new CreateContractRequest();
//        createContractRequest.setInsuranceType("HEALTH_INSURANCE");
//        createContractRequest.setUserId("1");
//        createContractRequest.setBasicSalary("123");
//
//        String userId = createContractRequest.getUserId();
//        when(userMapper.findById(userId)).thenReturn(new User()); // Mock user exists
//        doNothing().when(applicationUtils).checkValidateFile(eq(Contract.class), any(MultipartFile.class));
//
//        int result = contractService.addContract(createContractRequest);
//
//        verify(userMapper).findById(userId);
//        assertEquals(1, result);
//    }

//    @Test
//    public void testUpdateContract() {
//        UpdateContractRequest updateContractRequest = new UpdateContractRequest();
//
//        String contractId = updateContractRequest.getId();
//        Contract contract = new Contract();
//
//        when(contractMapper.findById(contractId)).thenReturn(contract);
//
//        updateContractRequest.setInsuranceType("HEALTH_INSURANCE");
//        int result = contractService.updateContract(updateContractRequest);
//
//        verify(contractMapper).findById(contractId);
//
//        assertEquals(1, result);
//    }

    @Test
    public void testDeleteContract() {
        String contractId = "1";
        Contract contract = new Contract(); // Create a sample Contract
        when(contractMapper.findById(contractId)).thenReturn(contract);

        int result = contractService.deleteContract(contractId);

        verify(contractMapper).findById(contractId);
        verify(contractMapper).changeStatusContract(contractId, StatusContractEnum.INACTIVE.toString());
        assertEquals(1, result);
    }

}
