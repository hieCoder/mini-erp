package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.converter.ManagementTimeConvert;
import com.shsoftvina.erpshsoftvina.converter.TaskConverter;
import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.ManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.DataOfDayDto;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.service.impl.ManagementTimeDayServiceImpl;
import com.shsoftvina.erpshsoftvina.service.impl.TaskServiceImpl;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class ManagementTimeServiceTest {
    @InjectMocks
    private ManagementTimeDayServiceImpl managementTimeDayService;

    @Mock
    private ManagementTimeDayMapper managementTimeDayMapper;

    @Mock
    private ManagementTimeConvert managementTimeConvert;

    @Mock
    private UserMapper userMapper;

    @Mock
    private ApplicationUtils applicationUtils;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

//    @Test
//    public void testFindAllByMonthYear() {
//        // Arrange
//        String userId = "123";
//        String startDate = "2023-01-01";
//        String endDate = "2023-01-31";
//
//        // Mock the behavior of userMapper
//        when(userMapper.findById(userId)).thenReturn(new User());
//
//        // Mock the behavior of managementTimeDayMapper
//        List<ManagementTimeDay> managementTimeDays = new ArrayList<>();
//        // Add your sample managementTimeDay objects to the list
//        // managementTimeDays.add(new ManagementTimeDay(...));
//        // ...
//        when(managementTimeDayMapper.findAllByMonthYear(userId, startDate, endDate)).thenReturn(managementTimeDays);
//
//        // Act
//        List<DayResponse> result = managementTimeDayService.findAllByMonthYear(userId, startDate, endDate);
//
//        // Assert
//        assertNotNull(result);
//        // Perform additional assertions on the result as needed
//    }

    @Test
    public void testFindById_WithValidId() {
        String id = "validId";

        // Tạo một đối tượng User và cấu hình nó
        User user = new User();
        user.setId("userId"); // Cấu hình giá trị ID cho User

        // Tạo một đối tượng ManagementTimeDay và cấu hình nó
        ManagementTimeDay managementTimeDay = new ManagementTimeDay();
        managementTimeDay.setUser(user);

        // Cấu hình trả về của findById
        when(managementTimeDayMapper.findById(id)).thenReturn(managementTimeDay);

        DayResponse result = managementTimeDayService.findById(id);

        // Kiểm tra rằng phương thức findById đã được gọi
        verify(managementTimeDayMapper, times(1)).findById(id);

        // Kiểm tra rằng phương thức checkUserAllow đã được gọi
        verify(applicationUtils, times(1)).checkUserAllow(user.getId());

        // Kiểm tra kết quả
        assertEquals(managementTimeConvert.toResponse(managementTimeDay), result);
    }


    @Test
    public void testFindById_WithInvalidId() {
        String id = "invalidId";
        when(managementTimeDayMapper.findById(id)).thenReturn(null);

        DayResponse result = managementTimeDayService.findById(id);

        // Kiểm tra rằng phương thức findById đã được gọi
        verify(managementTimeDayMapper, times(1)).findById(id);

        // Kiểm tra rằng phương thức checkUserAllow không được gọi khi không tìm thấy đối tượng
        verify(applicationUtils, times(0)).checkUserAllow(any());

        // Kiểm tra kết quả
        assertNull(result);
    }

    @Test
    public void testFindByDay_WithValidData() {
        String userId = "validUserId";
        String day = "validDay";

        // Tạo một mock cho User
        User user = mock(User.class);
        when(user.getId()).thenReturn(userId);

        ManagementTimeDay managementTimeDay = new ManagementTimeDay();
        managementTimeDay.setUser(user);

        when(managementTimeDayMapper.findByDay(userId, day)).thenReturn(managementTimeDay);

        DayResponse result = managementTimeDayService.findByDay(userId, day);

        // Kiểm tra rằng phương thức findByDay đã được gọi
        verify(managementTimeDayMapper, times(1)).findByDay(userId, day);

        // Kiểm tra rằng phương thức checkUserAllow đã được gọi
        verify(applicationUtils, times(1)).checkUserAllow(userId);

        // Kiểm tra kết quả
        assertEquals(managementTimeConvert.toResponse(managementTimeDay), result);
    }


    @Test
    public void testFindByDay_WithInvalidData() {
        String userId = "invalidUserId";
        String day = "invalidDay";
        when(managementTimeDayMapper.findByDay(userId, day)).thenReturn(null);

        DayResponse result = managementTimeDayService.findByDay(userId, day);

        // Kiểm tra rằng phương thức findByDay đã được gọi
        verify(managementTimeDayMapper, times(1)).findByDay(userId, day);

        // Kiểm tra rằng phương thức checkUserAllow không được gọi khi không tìm thấy đối tượng
        verify(applicationUtils, times(0)).checkUserAllow(any());

        // Kiểm tra kết quả
        assertNull(result);
    }

//    @Test
//    public void testFindDayResponse_WithValidId() {
//        String userId = "validUserId";
//        String day = "validDay";
//        String id = "validId";
//
//        // Tạo một mock cho ManagementTimeDay
//        ManagementTimeDay managementTimeDayMock = mock(ManagementTimeDay.class);
//
//        // Tạo một mock cho User
//        User userMock = mock(User.class);
//        when(userMock.getId()).thenReturn(userId);
//
//        when(managementTimeDayMock.getUser()).thenReturn(userMock);
//
//        when(managementTimeDayMapper.findById(id)).thenReturn(managementTimeDayMock);
//
//        DayResponse result = managementTimeDayService.findDayResponse(userId, day, id);
//
//        // Kiểm tra rằng phương thức findById đã được gọi khi id hợp lệ
//        verify(managementTimeDayService, times(1)).findById(id);
//
//        // Kiểm tra rằng phương thức findByDay không được gọi khi findById trả về kết quả
//        verify(managementTimeDayService, times(0)).findByDay(userId, day);
//
//        // Kiểm tra kết quả
//        // ...
//    }
//
//    @Test
//    public void testFindDayResponse_WithInvalidIdAndDay() {
//        String userId = "invalidUserId";
//        String day = "invalidDay";
//        String id = "invalidId";
//        when(managementTimeDayService.findById(id)).thenReturn(null);
//        when(managementTimeDayService.findByDay(userId, day)).thenReturn(null);
//
//        DayResponse result = managementTimeDayService.findDayResponse(userId, day, id);
//
//        // Kiểm tra rằng phương thức findById đã được gọi khi id không hợp lệ
//        verify(managementTimeDayService, times(1)).findById(id);
//
//        // Kiểm tra rằng phương thức findByDay đã được gọi khi id không hợp lệ và không tìm thấy đối tượng
//        verify(managementTimeDayService, times(1)).findByDay(userId, day);
//
//        // Kiểm tra kết quả
//        // ...
//    }

}
