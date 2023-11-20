package com.shsoftvina.erpshsoftvina.api;


import com.shsoftvina.erpshsoftvina.model.request.contract.CreateContractRequest;
import com.shsoftvina.erpshsoftvina.model.request.contract.UpdateContractRequest;
import com.shsoftvina.erpshsoftvina.service.ContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/contracts")
public class ContractApi {

    @Autowired
    private ContractService contractService;

    @PostMapping
    public ResponseEntity<?> createContract(@Valid CreateContractRequest createContractRequest) {
        return ResponseEntity.ok(contractService.addContract(createContractRequest));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getContract(@PathVariable String id) {
        return ResponseEntity.ok(contractService.findById(id));
    }

    @PostMapping("/updation")
    public ResponseEntity<?> updateContract(@Valid UpdateContractRequest updateContractRequest) {
        return ResponseEntity.ok(contractService.updateContract(updateContractRequest));
    }

    @GetMapping("/history/{id}")
    public ResponseEntity<?> getHistory(@PathVariable String id) {
        return ResponseEntity.ok(contractService.getHistoryContract(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteContract(@PathVariable String id) {
        return ResponseEntity.ok(contractService.deleteContract(id));
    }
}