package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.PageUserListRespone;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.when;

public class UserApiTest {

    @InjectMocks
    private UserApi userApi;

    @Mock
    private UserService userService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetAllUser() {
        String sort = "asc";
        String search = "sample search";
        int page = 1;
        int pageSize = 10;
        String status = "ACTIVE";

        PageUserListRespone mockResponse = new PageUserListRespone(/* add your mock data here */);
        when(userService.getAllUser(search, sort, page, pageSize, status)).thenReturn(mockResponse);

        ResponseEntity<?> responseEntity = userApi.getAllUser(sort, search, page, pageSize, status);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }

    @Test
    void testUpdateUser() {
        UserUpdateRequest userUpdateRequest = new UserUpdateRequest();
        userUpdateRequest.setId("1");
        userUpdateRequest.setEmail("hieuzzz601@gmail.com");

        when(userService.updateUserDetail(userUpdateRequest)).thenReturn(1);

        // Gọi phương thức updateUser của userController
        ResponseEntity<?> responseEntity = userApi.updateUser(userUpdateRequest);

        // Kiểm tra kết quả
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, responseEntity.getBody());
    }

    @Test
    public void testFindUserDetail() {
        String userId = "1";

        UserDetailResponse mockResponse = new UserDetailResponse();
        when(userService.findUserDetail(userId)).thenReturn(mockResponse);

        ResponseEntity<?> responseEntity = userApi.findUserDetail(userId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }

    @Test
    public void testDeleteUser() {
        String userId = "1";

        when(userService.deleteUser(userId)).thenReturn(1);

        ResponseEntity<?> responseEntity = userApi.deleteUser(userId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testActiveUserRegisterRequest() {
        UserActiveRequest userActiveRequest = new UserActiveRequest(/* add your mock data here */);
        when(userService.activeUserRegisterRequest(userActiveRequest)).thenReturn(true);

        ResponseEntity<Boolean> responseEntity = userApi.activeUserRegisterRequest(userActiveRequest);

        assertTrue(responseEntity.getBody());
    }

    @Test
    public void testRejectUserRegisterRequest() {
        String userId = "1";
        when(userService.rejectUserRegisterRequest(userId)).thenReturn(true);

        ResponseEntity<Boolean> responseEntity = userApi.rejectUserRegisterRequest(userId);

        assertTrue(responseEntity.getBody());
    }

    @Test
    public void testGetAllFullname() {
        // Create a sample response
        List<Map<String, Object>> mockResponse = new ArrayList<>();
        when(userService.getAllFullname()).thenReturn(mockResponse);

        ResponseEntity<?> responseEntity = userApi.getAllFullname();

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(mockResponse, responseEntity.getBody());
    }
}
