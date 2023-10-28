package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.converter.TaskConverter;
import com.shsoftvina.erpshsoftvina.entity.Task;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.task.PriorityTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusDeleteTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusTaskEnum;
import com.shsoftvina.erpshsoftvina.exception.NotAllowException;
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
    public void testRegisterTask_Success() {
        TaskRegisterRequest request = new TaskRegisterRequest();
        request.setUserId("validUserId");
        request.setPriority(PriorityTaskEnum.LOW.name());

        User mockUser = new User();

        when(userMapper.findById("validUserId")).thenReturn(mockUser);

        when(taskMapper.registerTask(any())).thenReturn(1);

        int result = taskService.registerTask(request);

        verify(userMapper).findById("validUserId");

        verify(taskMapper).registerTask(any());

        assertEquals(1, result);
    }

    @Test
    public void testRegisterTask_UserNotFound() {
        TaskRegisterRequest request = new TaskRegisterRequest();
        request.setUserId("nonExistentUserId");
        request.setPriority(PriorityTaskEnum.LOW.name());

        when(userMapper.findById("nonExistentUserId")).thenReturn(null);

        assertThrows(NotFoundException.class, () -> taskService.registerTask(request));

        verify(userMapper).findById("nonExistentUserId");
    }

    @Test
    public void testRegisterTask_PriorityNotFound() {
        TaskRegisterRequest request = new TaskRegisterRequest();
        request.setUserId("validUserId");
        request.setPriority("InvalidPriority");

        User mockUser = new User();

        when(userMapper.findById("validUserId")).thenReturn(mockUser);

        when(taskMapper.registerTask(any())).thenReturn(1);

        assertThrows(NotFoundException.class, () -> taskService.registerTask(request));

        verify(userMapper).findById("validUserId");
    }

    @Test
    public void testRegisterTask_ExceptionDuringRegistration() {
        TaskRegisterRequest request = new TaskRegisterRequest();
        request.setUserId("validUserId");
        request.setPriority(PriorityTaskEnum.LOW.name());

        User mockUser = new User();

        when(userMapper.findById("validUserId")).thenReturn(mockUser);

        when(taskMapper.registerTask(any())).thenThrow(new RuntimeException("Registration failed"));

        int result = taskService.registerTask(request);

        verify(userMapper).findById("validUserId");

        verify(taskMapper).registerTask(any());

        assertEquals(0, result);
    }

    @Test
    public void testUpdateTask_Success() {
        TaskUpdateRequest request = new TaskUpdateRequest();
        request.setId("validTaskId");
        request.setPriority(PriorityTaskEnum.LOW.name());

        Task mockTask = new Task();

        when(taskMapper.findById("validTaskId")).thenReturn(mockTask);
        when(taskMapper.updateTask(any())).thenReturn(1);

        int result = taskService.updateTask(request);

        verify(taskMapper).findById("validTaskId");
        verify(taskMapper).updateTask(any());

        assertEquals(1, result);
    }

    @Test
    public void testUpdateTask_TaskNotFound() {
        TaskUpdateRequest request = new TaskUpdateRequest();
        request.setId("nonExistentTaskId");
        request.setPriority(PriorityTaskEnum.LOW.name());

        when(taskMapper.findById("nonExistentTaskId")).thenReturn(null);

        assertThrows(NotFoundException.class, () -> taskService.updateTask(request));
    }

    @Test
    public void testUpdateTask_InvalidPriority() {
        TaskUpdateRequest request = new TaskUpdateRequest();
        request.setId("validTaskId");
        request.setPriority("InvalidPriority");

        Task mockTask = new Task();
        when(taskMapper.findById("validTaskId")).thenReturn(mockTask);

        assertThrows(NotFoundException.class, () -> taskService.updateTask(request));
    }

    @Test
    public void testUpdateTask_ExceptionDuringUpdate() {
        TaskUpdateRequest request = new TaskUpdateRequest();
        request.setId("validTaskId");
        request.setPriority(PriorityTaskEnum.LOW.name());
        request.setAction("ValidAction"); // Valid action
        // Other valid fields

        Task mockTask = new Task();
        // Mock the necessary dependencies.
        when(taskMapper.findById("validTaskId")).thenReturn(mockTask);
        // Mock taskMapper.updateTask to throw an exception.
        when(taskMapper.updateTask(any())).thenThrow(new RuntimeException("Update error"));

        // Expect that an exception during update results in returning 0.
        int result = taskService.updateTask(request);

        verify(taskMapper).findById("validTaskId");
        verify(taskMapper).updateTask(any());

        assertEquals(0, result);
    }

    @Test
    public void testUpdateTask_InvalidProgress() {
        TaskUpdateRequest request = new TaskUpdateRequest();
        request.setId("validTaskId");
        request.setPriority(PriorityTaskEnum.LOW.name());
        request.setAction("ValidAction");
        request.setProgress(50);

        Task mockTask = new Task();
        mockTask.setStatusTask(StatusTaskEnum.REGISTERED);

        when(taskMapper.findById("validTaskId")).thenReturn(mockTask);
        when(taskMapper.updateTask(any())).thenReturn(1);

        assertThrows(NotAllowException.class, () -> taskService.updateTask(request));
    }

    @Test
    public void testUpdateTask_InvalidStatusForProgressUpdate() {
        TaskUpdateRequest request = new TaskUpdateRequest();
        request.setId("validTaskId");
        request.setPriority(PriorityTaskEnum.LOW.name());
        request.setAction("ValidAction");
        request.setProgress(50);

        Task mockTask = new Task();
        mockTask.setStatusTask(StatusTaskEnum.CLOSED);

        when(taskMapper.findById("validTaskId")).thenReturn(mockTask);

        assertThrows(NotAllowException.class, () -> taskService.updateTask(request));
    }

    @Test
    public void testFindAll() {
        int start = 0;
        int pageSize = 10;
        String statusTask = "REGISTER";
        String search = "sample search";

        List<Task> mockTasks = Arrays.asList(new Task(), new Task());
        when(taskMapper.findAll(start, pageSize, statusTask, search)).thenReturn(mockTasks);
        when(taskConverter.toResponse(any())).thenReturn(new TaskShowResponse());

        List<TaskShowResponse> result = taskService.findAll(start, pageSize, statusTask, search);

        verify(taskMapper).findAll(start, pageSize, statusTask, search);
        verify(taskConverter, times(2)).toResponse(any());

        assertEquals(2, result.size());
    }

    @Test
    public void testGetTotalItem() {
        int start = 0;
        int pageSize = 10;
        String statusTask = "REGISTER";
        String search = "sample search";

        long mockTotalItemCount = 42;
        when(taskMapper.getTotalItem(start, pageSize, statusTask, search)).thenReturn(mockTotalItemCount);

        long result = taskService.getTotalItem(start, pageSize, statusTask, search);

        verify(taskMapper).getTotalItem(start, pageSize, statusTask, search);

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

        // Mock the taskMapper to return an empty list
        when(taskMapper.getStatusTaskCounts()).thenReturn(Collections.emptyList());

        // Call the method under test
        List<StatusTaskCountsResponse> result = taskService.getStatusTaskCount();

        // Verify that taskMapper.getStatusTaskCounts was called
        verify(taskMapper).getStatusTaskCounts();

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
