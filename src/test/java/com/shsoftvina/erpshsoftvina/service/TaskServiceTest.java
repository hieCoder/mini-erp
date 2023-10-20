package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.converter.TaskConverter;
import com.shsoftvina.erpshsoftvina.entity.Task;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.task.PriorityTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusDeleteTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusTaskEnum;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.exception.UnauthorizedException;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.task.StatusTaskCountsResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;
import com.shsoftvina.erpshsoftvina.service.impl.TaskServiceImpl;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

import java.util.*;

import static org.junit.Assert.assertThrows;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class TaskServiceTest {

    @InjectMocks
    private TaskServiceImpl taskService;

    @Mock
    private TaskMapper taskMapper;

    @Mock
    private TaskConverter taskConverter;

    @Mock
    private UserMapper userMapper;

    @Mock
    private ApplicationUtils applicationUtils;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testFindAll() {
        // Create sample input parameters
        int start = 0;
        int pageSize = 10;
        String statusTask = "REGISTER";
        String search = "sample search";
        String userRole = "OWNER";
        String userId = "1";

        List<Task> mockTasks = Arrays.asList(new Task(), new Task());
        when(taskMapper.findAll(start, pageSize, statusTask, search, userRole, userId)).thenReturn(mockTasks);
        when(taskConverter.toResponse(any())).thenReturn(new TaskShowResponse());

        List<TaskShowResponse> result = taskService.findAll(start, pageSize, statusTask, search, userRole, userId);

        verify(taskMapper).findAll(start, pageSize, statusTask, search, userRole, userId);
        verify(taskConverter, times(2)).toResponse(any());

        assertEquals(2, result.size());
    }

    @Test
    public void testGetTotalItem() {
        int start = 0;
        int pageSize = 10;
        String statusTask = "REGISTER";
        String search = "sample search";
        String userRole = "OWNER";
        String userId = "1";

        long mockTotalItemCount = 42;
        when(taskMapper.getTotalItem(start, pageSize, statusTask, search, userRole, userId)).thenReturn(mockTotalItemCount);

        long result = taskService.getTotalItem(start, pageSize, statusTask, search, userRole, userId);

        verify(taskMapper).getTotalItem(start, pageSize, statusTask, search, userRole, userId);

        assertEquals(mockTotalItemCount, result);
    }

    @Test
    public void testDeleteById_TaskFoundAndDeleted() {
        String taskId = "sampleTaskId";

        when(taskMapper.findById(taskId)).thenReturn(new Task());

        when(taskMapper.changeStatusTask(eq(taskId), eq(StatusDeleteTaskEnum.INACTIVE.toString()))).thenReturn(1);

        int result = taskService.deleteById(taskId);

        verify(taskMapper).findById(taskId);
        verify(taskMapper).changeStatusTask(eq(taskId), eq(StatusDeleteTaskEnum.INACTIVE.toString()));

        assertEquals(1, result);
    }

    @Test
    public void testDeleteById_TaskNotFound() {
        String taskId = "nonExistentTaskId";

        when(taskMapper.findById(taskId)).thenReturn(null);

        NotFoundException exception = assertThrows(NotFoundException.class, () -> taskService.deleteById(taskId));

        verify(taskMapper).findById(taskId);

        assertEquals("Id is not found", exception.getMessage()); // Update the expected message to match your NotFoundException implementation
    }

    @Test
    public void testDeleteById_DeletionFailure() {
        String taskId = "sampleTaskId";

        when(taskMapper.findById(taskId)).thenReturn(new Task());

        when(taskMapper.changeStatusTask(eq(taskId), eq(StatusDeleteTaskEnum.INACTIVE.toString()))).thenReturn(0);

        int result = taskService.deleteById(taskId);

        verify(taskMapper).findById(taskId);
        verify(taskMapper).changeStatusTask(eq(taskId), eq(StatusDeleteTaskEnum.INACTIVE.toString()));

        assertEquals(0, result);
    }

    @Test
    public void testGetStatusTaskCount_EmptyList() {
        // Sample user role and user ID
        String userRole = "ROLE_USER";
        String userId = "sampleUserId";

        // Mock the taskMapper to return an empty list
        when(taskMapper.getStatusTaskCounts(userRole, userId)).thenReturn(Collections.emptyList());

        // Call the method under test
        List<StatusTaskCountsResponse> result = taskService.getStatusTaskCount(userRole, userId);

        // Verify that taskMapper.getStatusTaskCounts was called
        verify(taskMapper).getStatusTaskCounts(userRole, userId);

        // Verify the result (empty list)
        assertEquals(Collections.emptyList(), result);
    }

    @Test
    public void testGetTaskByHashtag() {
        String userId = "sampleUserId";

        List<Map<String, Object>> mockData = Arrays.asList(new HashMap<>(), new HashMap<>()); // You can create sample data
        when(taskMapper.getTaskByHashtag(userId)).thenReturn(mockData);

        List<Map<String, Object>> result = taskService.getTaskByHashtag(userId);

        verify(taskMapper).getTaskByHashtag(userId);

        assertEquals(2, result.size());
    }

    @Test
    public void testFindById_ValidTaskId() {
        User sampleUser = new User();
        sampleUser.setId("sampleUserId");

        Task sampleTask = new Task();
        sampleTask.setId("validTaskId");
        sampleTask.setUser(sampleUser);

        TaskDetailResponse sampleResponse = new TaskDetailResponse();
        sampleResponse.setId("validTaskId");

        when(taskMapper.findById("validTaskId")).thenReturn(sampleTask);

        doNothing().when(applicationUtils).checkUserAllow(Mockito.anyString());

        when(taskConverter.toDetailResponse(sampleTask)).thenReturn(sampleResponse);

        TaskDetailResponse taskDetailResponse = taskService.findById("validTaskId");

        Mockito.verify(taskMapper).findById("validTaskId");

        Mockito.verify(applicationUtils).checkUserAllow(sampleUser.getId());

        assertEquals("validTaskId", taskDetailResponse.getId());
    }
}
