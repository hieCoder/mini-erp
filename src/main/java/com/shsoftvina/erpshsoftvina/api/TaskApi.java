package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskUpdateRequest;
import com.shsoftvina.erpshsoftvina.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/tasks")
public class TaskApi {

    @Autowired
    TaskService taskService;

    @GetMapping
    public ResponseEntity<?> findAll(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                     @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize,
                                     @RequestParam(name = "status", required = false, defaultValue = "ACTIVE") String status,
                                     @RequestParam(name = "search", required = false, defaultValue = "") String search) {
        return ResponseEntity.ok(taskService.findAll((page - 1) * pageSize, pageSize, status, search));
    }

    @PostMapping
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

    @GetMapping("/hashtag")
    public ResponseEntity<?> getTaskByHashtag(@RequestParam String userId,
                                              @RequestParam String hashtag){
        return ResponseEntity.ok(taskService.getTaskByHashtag(userId, hashtag));
    }
}