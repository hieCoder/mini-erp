package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.commenttask.CreateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.UpdateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;
import com.shsoftvina.erpshsoftvina.service.CommentTaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/comment-task")
public class CommentTaskApi {

    @Autowired
    CommentTaskService commentTaskService;

    @GetMapping("/{id}")
    public ResponseEntity<?> findById(@PathVariable("id") String id) {
        return ResponseEntity.ok(commentTaskService.findById(id));
    }

    @PostMapping
    public ResponseEntity<?> createCommentTask(@Valid CreateCommentTaskRequest createCommentTaskRequest) {
        CommentTaskResponse commentTaskResponse = commentTaskService.createCommentTask(createCommentTaskRequest);
        return ResponseEntity.ok(commentTaskResponse);
    }

    @PostMapping("/updation")
    public ResponseEntity<?> updateCommentTask(@Valid UpdateCommentTaskRequest updateCommentTaskRequest) {
        return ResponseEntity.ok(commentTaskService.updateCommentTask(updateCommentTaskRequest));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteComment(@PathVariable("id") String id){
        return ResponseEntity.ok(commentTaskService.deleteCommentTask(id));
    }
}
