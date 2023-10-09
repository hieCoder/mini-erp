package com.shsoftvina.erpshsoftvina.api;


import com.shsoftvina.erpshsoftvina.model.request.contract.CreateContractRequest;
import com.shsoftvina.erpshsoftvina.model.request.contract.UpdateContractRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.UserShowResponse;
import com.shsoftvina.erpshsoftvina.service.ContractService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/v1/contracts")
public class ContractApi {

    @Autowired
    private ContractService contractService;

    @PostMapping
    public ResponseEntity<?> createContract(CreateContractRequest createContractRequest) {
        return ResponseEntity.ok(contractService.addContract(createContractRequest));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getContract(@PathVariable String id) {
        return ResponseEntity.ok(contractService.findById(id));
    }

    @PostMapping("/updation")
    public ResponseEntity<?> updateContract(UpdateContractRequest updateContractRequest) {
        return ResponseEntity.ok(contractService.updateContract(updateContractRequest));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteContract(@PathVariable String id) {
        return ResponseEntity.ok(contractService.deleteContract(id));
    }
}