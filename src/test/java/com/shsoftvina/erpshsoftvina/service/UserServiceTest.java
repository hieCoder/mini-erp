package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.response.user.PageUserListRespone;
import com.shsoftvina.erpshsoftvina.model.response.user.IdAndFullnameUserResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.UserShowResponse;
import com.shsoftvina.erpshsoftvina.service.impl.UserServiceImpl;
import org.apache.ibatis.session.RowBounds;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class UserServiceTest {

    @InjectMocks
    private UserServiceImpl userServiceImpl;

    @Mock
    private UserMapper userMapper;

    @Mock
    private UserConverter userConverter;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetAllUser() {
        // Create sample input parameters
        String searchTerm = "sampleSearch";
        String sortDirection = "asc";
        int start = 1;
        int pageSize = 10;
        String status = "ACTIVE";

        // Create mock data for userMapper and userConverter
        List<User> mockUsers = Arrays.asList(new User(), new User());
        when(userMapper.getAllUser(eq(searchTerm), eq(sortDirection), eq(status), any(RowBounds.class))).thenReturn(mockUsers);

        when(userConverter.toListShowUserResponse(mockUsers)).thenReturn(Arrays.asList(new UserShowResponse(), new UserShowResponse()));
        when(userMapper.getTotalUser(status, searchTerm, sortDirection)).thenReturn(20L); // Set the expected total record count

        // Call the method you want to test
        PageUserListRespone response = userServiceImpl.getAllUser(searchTerm, sortDirection, start, pageSize, status);

        // Verify that the methods were called with the expected parameters
        verify(userConverter, times(1)).toListShowUserResponse(mockUsers);
        verify(userMapper).getTotalUser(status, searchTerm, sortDirection);


        assertEquals(2, response.getListUser().size());
    }

    @Test
    public void testFindUserDetail() {
        String userId = "1";
        User expectedUser = new User();


        when(userMapper.findById(userId)).thenReturn(expectedUser);

        UserDetailResponse response = userServiceImpl.findUserDetail(userId);

        verify(userMapper).findById(userId);

        UserDetailResponse expectedResponse = userConverter.toUserDetailResponse(expectedUser);
        assertEquals(expectedResponse, response);
    }

    @Test
    public void testFindUserIdFullName() {
        String userId = "1";
        User expectedUser = new User();

        when(userMapper.findById(userId)).thenReturn(expectedUser);

        IdAndFullnameUserResponse expectedResponse = userConverter.toIdAndFullnameUserResponse(expectedUser);
        IdAndFullnameUserResponse response = userServiceImpl.findIdAndFullNameOfUser(userId);

        verify(userMapper).findById(userId);
        assertEquals(expectedResponse, response);
    }

    @Test
    public void testDeleteUser() {
        String userId = "1";
        when(userMapper.changeStatusUser(userId, StatusUserEnum.INACTIVE.toString())).thenReturn(1);

        int result = userServiceImpl.deleteUser(userId);

        verify(userMapper).changeStatusUser(userId, StatusUserEnum.INACTIVE.toString());
        assertEquals(1, result);
    }

    //    @Test
//    public void testActiveUserRegisterRequest() {
//        UserActiveRequest userActiveRequest = new UserActiveRequest();
//        userActiveRequest.setStatus(StatusUserEnum.INACTIVE.getValue());
//
//        boolean result = userServiceImpl.activeUserRegisterRequest(userActiveRequest);
//
//        // Kiểm tra xem userMapper.activeUserRegister đã được gọi
//        verify(userMapper).activeUserRegister(any(User.class));
//        // Kiểm tra kết quả trả về
//        assertTrue(result);
//    }
    @Test
    public void testRejectUserRegisterRequest() {
        String userId = "your_user_id";
        User expectedUser = new User();

        when(userMapper.findById(userId)).thenReturn(expectedUser);
        when(userMapper.deleteUser(userId)).thenReturn(1);

        boolean result = userServiceImpl.rejectUserRegisterRequest(userId);

        verify(userMapper).findById(userId);
        verify(userMapper).deleteUser(userId);
        assertTrue(result);
    }

    @Test
    public void testFindByEmail_UserNotFound() {
        String email = "your_email@example.com";

        when(userMapper.findByEmail(email)).thenReturn(null);

        UserDetailResponse response = userServiceImpl.findByEmail(email);

        verify(userMapper).findByEmail(email);
        assertNull(response);
    }

    @Test
    public void testFindByEmail_UserFound() {
        String email = "your_email@example.com";
        User user = new User(); // Create a sample User

        when(userMapper.findByEmail(email)).thenReturn(user);
        UserDetailResponse expectedResponse = userConverter.toUserDetailResponse(user);

        UserDetailResponse response = userServiceImpl.findByEmail(email);

        verify(userMapper).findByEmail(email);
        assertEquals(expectedResponse, response);
    }

//    @Test
//    public void testUpdateUserDetail() {
//        UserUpdateRequest userUpdateRequest = new UserUpdateRequest();
//
//
//        String userId = userUpdateRequest.getId();
//        User user = new User(); // Create a sample User
//        user.setId("1");
//        user.setAddress("HCM");
//
//        when(userMapper.findById(userId)).thenReturn(user);
//        when(userMapper.updateUserProfile(user)).thenReturn(1);
//
//        int result = userServiceImpl.updateUserDetail(userUpdateRequest);
//
//        verify(userMapper).findById(userId);
//        verify(userMapper).updateUserProfile(any(User.class));
//        assertEquals(1, result);
//    }

    @Test
    public void testGetAllFullname() {
        List<Map<String, Object>> expectedList = new ArrayList<>(); // Create a sample list

        when(userMapper.getAllFullname()).thenReturn(expectedList);

        List<Map<String, Object>> resultList = userServiceImpl.getAllFullname();

        verify(userMapper).getAllFullname();
        assertEquals(expectedList, resultList);
    }
}
