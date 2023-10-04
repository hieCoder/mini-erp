package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.response.todo.TodoManagementBoardResponse;
import com.shsoftvina.erpshsoftvina.service.TodoManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/to-do")
public class TodoManagementApi {
    @Autowired
    private TodoManagementService todoManagementService;
    @GetMapping
    public ResponseEntity<?> getTotalElementPerMonth() {
        TodoManagementBoardResponse todo = todoManagementService.findTotalElementPerMonth();
        return new ResponseEntity<>(todo,HttpStatus.OK);
    }
}
