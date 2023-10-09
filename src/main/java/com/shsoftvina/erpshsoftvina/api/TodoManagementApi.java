package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.todo.TodoManagementEditListRequest;
import com.shsoftvina.erpshsoftvina.model.request.todo.TodoManagementListRequest;
import com.shsoftvina.erpshsoftvina.model.response.todo.TodoManagementBoardResponse;
import com.shsoftvina.erpshsoftvina.service.TodoManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
@RequestMapping("/api/v1/to-do")
public class TodoManagementApi {
    @Autowired
    private TodoManagementService todoManagementService;
    @GetMapping("/{userId}")
    public ResponseEntity<?> getTotalElementPerMonth(@PathVariable("userId") String id,
                                                     @RequestParam(name = "date",required = false) @DateTimeFormat(pattern = "yyyy-MM")
                                                     Date date) {
        TodoManagementBoardResponse todo = todoManagementService.findTotalElementPerMonth(id,date);
        return new ResponseEntity<>(todo,HttpStatus.OK);
    }
    @PostMapping()
    public ResponseEntity<?> postTodoListByUser(@RequestBody TodoManagementListRequest todoManagementListRequest) {
        todoManagementService.postTodoListByUser(todoManagementListRequest);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PutMapping()
    public ResponseEntity<?> editTodoListByUser(@RequestBody TodoManagementEditListRequest todoManagementListRequest) {
        todoManagementService.editTodoListByUser(todoManagementListRequest);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
