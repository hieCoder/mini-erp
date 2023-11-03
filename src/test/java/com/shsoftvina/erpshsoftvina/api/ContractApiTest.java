package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.contract.CreateContractRequest;
import com.shsoftvina.erpshsoftvina.model.request.contract.UpdateContractRequest;
import com.shsoftvina.erpshsoftvina.model.response.contract.ContractResponse;
import com.shsoftvina.erpshsoftvina.service.ContractService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ContractApiTest {

    @InjectMocks
    private ContractApi contractApi;

    @Mock
    private ContractService contractService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

//    @Test
//    public void testCreateContract() {
//        CreateContractRequest createContractRequest = new CreateContractRequest();
//        createContractRequest.setUserId("1");
//        createContractRequest.setInsuranceType("HEALTH_INSURANCE");
//
//        Mockito.when(contractService.addContract(createContractRequest))
//                .thenReturn(1);
//
//
//        ResponseEntity<?> responseEntity = contractApi.createContract(createContractRequest);
//
//        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
//        assertEquals(1, responseEntity.getBody());
//    }

    @Test
    public void testGetContract() {
        String contractId = "1";

        ContractResponse contractResponse = new ContractResponse();

        Mockito.when(contractService.findById(contractId))
                .thenReturn(contractResponse);

        // Gọi phương thức getContract của API với ID đã định
        ResponseEntity<?> responseEntity = contractApi.getContract(contractId);

        // Kiểm tra kết quả trả về từ phương thức
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(contractResponse, responseEntity.getBody());
    }


    @Test
    public void testGetContractByUser() {
        String userId = "1";

        List<ContractResponse> userContracts = new ArrayList<>();

        Mockito.when(contractService.getContractByUser(userId))
                .thenReturn(userContracts);

        ResponseEntity<?> responseEntity = contractApi.getContractByUser(userId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(userContracts, responseEntity.getBody());
    }

    @Test
    public void testUpdateContract() {
        UpdateContractRequest updateContractRequest = new UpdateContractRequest();

        Mockito.when(contractService.updateContract(updateContractRequest))
                .thenReturn(1);

        ResponseEntity<?> responseEntity = contractApi.updateContract(updateContractRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, responseEntity.getBody());
    }

    @Test
    public void testDeleteContract() {
        String contractId = "1";

        Mockito.when(contractService.deleteContract(contractId))
                .thenReturn(1);

        ResponseEntity<?> responseEntity = contractApi.deleteContract(contractId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, responseEntity.getBody());
    }


}
