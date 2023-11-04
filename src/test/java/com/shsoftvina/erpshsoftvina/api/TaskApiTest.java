package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.constant.TaskConstant;
import com.shsoftvina.erpshsoftvina.model.request.task.ListTaskRequest;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.task.StatusTaskCountsResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;
import com.shsoftvina.erpshsoftvina.service.TaskService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

public class TaskApiTest {
    @InjectMocks
    private TaskApi taskApi;

    @Mock
    private TaskService taskService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testFindAll() {
        ListTaskRequest listTaskRequest = new ListTaskRequest();
        listTaskRequest.setPage(1);
        listTaskRequest.setPageSize(10);
        listTaskRequest.setStatusTask("REGISTERED");
        listTaskRequest.setSearch("sample search");

        List<TaskShowResponse> mockResponse = Collections.singletonList(new TaskShowResponse());
        when(taskService.findAll(0, 10, "REGISTERED", "sample search")).thenReturn(mockResponse);

        ResponseEntity<?> responseEntity = taskApi.findAll(listTaskRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }

    @Test
    public void testFindAllWithDefaultPageAndPageSize() {
        ListTaskRequest listTaskRequest = new ListTaskRequest();
        listTaskRequest.setStatusTask("REGISTERED");
        listTaskRequest.setSearch("sample search");

        List<TaskShowResponse> mockResponse = Collections.singletonList(new TaskShowResponse());
        when(taskService.findAll(0, TaskConstant.pageSizeDefault, "REGISTERED", "sample search")).thenReturn(mockResponse);

        ResponseEntity<?> responseEntity = taskApi.findAll(listTaskRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }

    @Test
    public void testRegisterTask() {
        TaskRegisterRequest taskRegisterRequest = new TaskRegisterRequest();
        taskRegisterRequest.setUserId("validUserId");
        taskRegisterRequest.setPriority("LOW");

        when(taskService.registerTask(taskRegisterRequest)).thenReturn(1);

        ResponseEntity<?> responseEntity = taskApi.registerTask(taskRegisterRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, responseEntity.getBody());
    }

    @Test
    public void testUpdateTask() {
        TaskUpdateRequest taskUpdateRequest = new TaskUpdateRequest();
        taskUpdateRequest.setId("validTaskId");
        taskUpdateRequest.setProgress(50);
        taskUpdateRequest.setAction("VALID_ACTION");

        when(taskService.updateTask(taskUpdateRequest)).thenReturn(1);

        ResponseEntity<?> responseEntity = taskApi.updateTask(taskUpdateRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, responseEntity.getBody());
    }

    @Test
    public void testGetStatusTaskCount() {
        String userRole = "ROLE_USER";
        String userId = "sampleUserId";

        List<StatusTaskCountsResponse> mockResponse = Collections.singletonList(new StatusTaskCountsResponse());
        when(taskService.getStatusTaskCount()).thenReturn(mockResponse);

        ResponseEntity<?> responseEntity = taskApi.getStatusTaskCount();

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }

    @Test
    public void testGetDetailTask() {
        String taskId = "validTaskId";
        TaskDetailResponse mockResponse = new TaskDetailResponse();

        when(taskService.findById(taskId)).thenReturn(mockResponse);

        ResponseEntity<?> responseEntity = taskApi.getDetailTask(taskId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }

    @Test
    public void testDeleteTask() {
        String taskId = "validTaskId";

        when(taskService.deleteById(taskId)).thenReturn(1);

        ResponseEntity<?> responseEntity = taskApi.deleteTask(taskId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, responseEntity.getBody());
    }

    @Test
    public void testGetTaskByHashtag() {
        String userId = "sampleUserId";

        List<?> mockResponse = Collections.singletonList(Collections.emptyMap());
        when(taskService.getTaskByHashtag(userId)).thenReturn((List<Map<String, Object>>) mockResponse);

        ResponseEntity<?> responseEntity = taskApi.getTaskByHashtag(userId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }

    @Test
    public void testGetTotalItem() {
        ListTaskRequest listTaskRequest = new ListTaskRequest();
        listTaskRequest.setPage(1);
        listTaskRequest.setPageSize(10);
        listTaskRequest.setStatusTask("REGISTERED");
        listTaskRequest.setSearch("sample search");

        when(taskService.getTotalItem("REGISTERED", "sample search")).thenReturn(42L);

        ResponseEntity<?> responseEntity = taskApi.getTotalItem(listTaskRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(42L, responseEntity.getBody());
    }

    @Test
    public void testGetTotalItemWithDefaultPageAndPageSize() {
        ListTaskRequest listTaskRequest = new ListTaskRequest();
        listTaskRequest.setStatusTask("REGISTERED");
        listTaskRequest.setSearch("sample search");

        when(taskService.getTotalItem("REGISTERED", "sample search")).thenReturn(42L);

        ResponseEntity<?> responseEntity = taskApi.getTotalItem(listTaskRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(42L, responseEntity.getBody());
    }
}