package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.service.ContractService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

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
