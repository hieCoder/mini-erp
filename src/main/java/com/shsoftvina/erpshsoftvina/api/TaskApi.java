package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.constant.TaskConstant;
import com.shsoftvina.erpshsoftvina.enums.task.StatusDeleteTaskEnum;
import com.shsoftvina.erpshsoftvina.model.request.task.ListTaskRequest;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskUpdateRequest;
import com.shsoftvina.erpshsoftvina.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/tasks")
public class TaskApi {

    @Autowired
    TaskService taskService;

    @PostMapping
    public ResponseEntity<?> findAll(@RequestBody ListTaskRequest listTaskRequest) {
        Integer page = listTaskRequest.getPage() != null?listTaskRequest.getPage():1;
        int pageSize = listTaskRequest.getPageSize() != null?listTaskRequest.getPageSize(): TaskConstant.pageSizeDefault;
        return ResponseEntity.ok(taskService.findAll((page-1) * pageSize, pageSize, listTaskRequest.getStatusTask(), listTaskRequest.getSearch()));
    }

    @PostMapping("/register")
    public ResponseEntity<?> registerTask(@Valid @RequestBody TaskRegisterRequest taskRegisterRequest) {
        return ResponseEntity.ok(taskService.registerTask(taskRegisterRequest));
    }

    @PutMapping
    public ResponseEntity<?> updateTask(@Valid @RequestBody TaskUpdateRequest taskUpdateRequest){
        return ResponseEntity.ok(taskService.updateTask(taskUpdateRequest));
    }

    @GetMapping("/status-task-count")
    public ResponseEntity<?> getStatusTaskCount(){
        return ResponseEntity.ok(taskService.getStatusTaskCount());
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getDetailTask(@PathVariable String id){
        return ResponseEntity.ok(taskService.findById(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteTask(@PathVariable("id") String id){
        return ResponseEntity.ok(taskService.deleteById(id));
    }

    @GetMapping("/hashtag/{userId}")
    public ResponseEntity<?> getTaskByHashtag(@PathVariable("userId") String userId){
        return ResponseEntity.ok(taskService.getTaskByHashtag(userId));
    }

    @PostMapping("/count")
    public ResponseEntity<?> getTotalItem(@RequestBody ListTaskRequest listTaskRequest){
        Integer page = listTaskRequest.getPage() != null?listTaskRequest.getPage():1;
        int pageSize = listTaskRequest.getPageSize() != null?listTaskRequest.getPageSize():TaskConstant.pageSizeDefault;
        return ResponseEntity.ok(taskService.getTotalItem((page-1) * pageSize, pageSize, listTaskRequest.getStatusTask(), listTaskRequest.getSearch()));
    }
}