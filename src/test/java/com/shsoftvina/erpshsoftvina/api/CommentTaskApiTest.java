package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.api.CommentTaskApi;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.CreateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.UpdateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;
import com.shsoftvina.erpshsoftvina.service.CommentTaskService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

public class CommentTaskApiTest {

    @InjectMocks
    private CommentTaskApi commentTaskApi;

    @Mock
    private CommentTaskService commentTaskService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testFindById() {
        String commentTaskId = "sampleCommentTaskId";

        when(commentTaskService.findById(commentTaskId)).thenReturn(new CommentTaskResponse());

        ResponseEntity<?> responseEntity = commentTaskApi.findById(commentTaskId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testCreateCommentTask() {
        CreateCommentTaskRequest request = new CreateCommentTaskRequest();

        CommentTaskResponse commentTaskResponse = new CommentTaskResponse();

        when(commentTaskService.createCommentTask(request)).thenReturn(commentTaskResponse);

        ResponseEntity<?> responseEntity = commentTaskApi.createCommentTask(request);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testUpdateCommentTask() {
        UpdateCommentTaskRequest request = new UpdateCommentTaskRequest();

        CommentTaskResponse commentTaskResponse = new CommentTaskResponse();

        when(commentTaskService.updateCommentTask(request)).thenReturn(commentTaskResponse);

        ResponseEntity<?> responseEntity = commentTaskApi.updateCommentTask(request);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testDeleteCommentTask() {
        String commentTaskId = "sampleCommentTaskId";


        when(commentTaskService.deleteCommentTask(commentTaskId)).thenReturn(1);

        ResponseEntity<?> responseEntity = commentTaskApi.deleteComment(commentTaskId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }
}