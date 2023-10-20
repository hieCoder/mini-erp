package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.UpdateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentNotificationResponse;
import com.shsoftvina.erpshsoftvina.service.CommentNotificationService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.mockito.Mockito.when;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class CommentNotificationApiTest {

    @InjectMocks
    private CommentNotificationApi commentNotificationApi;

    @Mock
    private CommentNotificationService commentNotificationService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testGetComment() {
        String commentId = "1";
        CommentNotificationResponse mockResponse = new CommentNotificationResponse();

        when(commentNotificationService.findById(commentId)).thenReturn(mockResponse);
        ResponseEntity<?> responseEntity = commentNotificationApi.getComment(commentId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }

    @Test
    public void testCommentNotification() {
        CreateCommentNotificationRequest createCommentNotificationRequest = new CreateCommentNotificationRequest();
        String notificationId = "1";
        String content = "test content";
        String parentId = "01";
        createCommentNotificationRequest.setNotificationId(notificationId);
        createCommentNotificationRequest.setContent(content);
        createCommentNotificationRequest.setParentId(parentId);
        CommentNotificationResponse mockResponse = new CommentNotificationResponse();

        when(commentNotificationService.createCommentNotification(createCommentNotificationRequest)).thenReturn(mockResponse);
        ResponseEntity<?> responseEntity = commentNotificationApi.commentNotification(createCommentNotificationRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }

    @Test
    public void testUpdateComment() {
        UpdateCommentNotificationRequest updateCommentNotificationRequest = new UpdateCommentNotificationRequest();
        String content = "test content";
        String commentId = "1";
        updateCommentNotificationRequest.setContent(content);
        updateCommentNotificationRequest.setId(commentId);
        CommentNotificationResponse mockResponse = new CommentNotificationResponse();

        when(commentNotificationService.updateCommentNotification(updateCommentNotificationRequest)).thenReturn(mockResponse);
        ResponseEntity<?> responseEntity = commentNotificationApi.updateComment(updateCommentNotificationRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());

    }

    @Test
    public void testDeleteComment() {
        String commentId = "1";
        when(commentNotificationService.deleteCommentNotification(commentId)).thenReturn(1);

        ResponseEntity<?> responseEntity = commentNotificationApi.deleteComment(commentId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

}
