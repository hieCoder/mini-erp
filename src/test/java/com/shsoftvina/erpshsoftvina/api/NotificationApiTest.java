package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationShowResponse;
import com.shsoftvina.erpshsoftvina.service.NotificationService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collections;
import java.util.List;

import static org.mockito.Mockito.when;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class NotificationApiTest {

    @InjectMocks
    private NotificationApi notificationApi;

    @Mock
    private NotificationService notificationService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetAllNoti() {
        int page = 1;
        int pageSize = 10;
        String search = "search test";

        List<NotificationShowResponse> mockResponse = Collections.singletonList(new NotificationShowResponse());
        when(notificationService.getAllNoti((page - 1) * pageSize, pageSize, search)).thenReturn(mockResponse);
        MockHttpServletRequestBuilder requestBuilder = MockMvcRequestBuilders.get("/api/v1/notifications")
                .param("page", String.valueOf(page))
                .param("pageSize", String.valueOf(pageSize))
                .param("search", search);
        ResponseEntity<?> responseEntity = notificationApi.getAllNoti(page, pageSize, search);
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }

    @Test
    public void testCreateNoti() {
        CreateNotificationRequest createNotificationRequest = new CreateNotificationRequest();
        String userId = "1";
        String title  = "test title";
        String content = "test content";
        MockMultipartFile file1 = new MockMultipartFile("files", "file1.txt", "text/plain", "Hello, World!".getBytes());
        MockMultipartFile file2 = new MockMultipartFile("files", "file2.txt", "text/plain", "Spring Testing!".getBytes());
        MultipartFile[] files = {file1, file2};
        createNotificationRequest.setUserId(userId);
        createNotificationRequest.setTitle(title);
        createNotificationRequest.setContent(content);
        createNotificationRequest.setFiles(files);

        when(notificationService.createNoti(createNotificationRequest)).thenReturn(1);
        ResponseEntity<?> responseEntity = notificationApi.createNoti(createNotificationRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, responseEntity.getBody());
    }

    @Test
    public void testUpdateNotification() {
        UpdateNotificationRequest updateNotificationRequest = new UpdateNotificationRequest();
        String id = "1";
        String title  = "test title";
        String content = "test content";
        String[] oldFile = {"test.xls", "test2.xls"};
        MockMultipartFile file1 = new MockMultipartFile("files", "file1.txt", "text/plain", "Hello, World!".getBytes());
        MockMultipartFile file2 = new MockMultipartFile("files", "file2.txt", "text/plain", "Spring Testing!".getBytes());
        MultipartFile[] files = {file1, file2};
        NotificationDetailResponse mockResponse = new NotificationDetailResponse();

        when(notificationService.updateNotification(updateNotificationRequest, id)).thenReturn(mockResponse);
        ResponseEntity<?> responseEntity = notificationApi.updateNotification(updateNotificationRequest, id);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }

    @Test
    public void testDelNoti() {
        String notificationId = "1"; // Replace with a valid notification ID

        when(notificationService.delNoti(notificationId)).thenReturn(true); // Assuming your service returns true for a successful deletion

        ResponseEntity<?> responseEntity = notificationApi.delNoti(notificationId);

        // Assert that the response status code is HttpStatus.OK (200)
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testNotificationDetail() {
        String notificationId = "1"; // Replace with a valid notification ID
        NotificationDetailResponse mockResponse = new NotificationDetailResponse(); // Replace with a mock response object

        when(notificationService.findById(notificationId)).thenReturn(mockResponse);

        ResponseEntity<?> responseEntity = notificationApi.notificationDetail(notificationId);

        // Assert that the response status code is HttpStatus.OK (200)
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        // Assert that the response body matches the mock response
        assertEquals(mockResponse, responseEntity.getBody());
    }

}