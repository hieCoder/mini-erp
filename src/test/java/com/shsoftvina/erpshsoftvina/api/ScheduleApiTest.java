package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.response.schedule.ScheduleListResponse;
import com.shsoftvina.erpshsoftvina.service.ScheduleService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.mockito.Mockito;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ScheduleApiTest {

    @InjectMocks
    private ScheduleApi controller;

    @Mock
    private ScheduleService scheduleService;

    private MockMvc mockMvc;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
    }

    @Test
    public void testGetScheduleDetail() throws Exception {
        String userId = "123";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String startDateStr = "2023-01-01";
        String endDateStr = "2023-12-31";

        Date startDate = dateFormat.parse(startDateStr);
        Date endDate = dateFormat.parse(endDateStr);

        ScheduleListResponse mockResponse = new ScheduleListResponse();

        Mockito.when(scheduleService.getScheduleDetail(userId, startDate, endDate)).thenReturn(mockResponse);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/schedules/" + userId)
                .param("startDate", startDateStr)
                .param("endDate", endDateStr)
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(MockMvcResultMatchers.status().isOk());
    }

    @Test
    public void testGetScheduleDetailWithNullDates() throws Exception {
        String userId = "123";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String startDateStr = "2023-01-01";
        String endDateStr = "2023-12-31";

        Date startDate = dateFormat.parse(startDateStr);
        Date endDate = dateFormat.parse(endDateStr);

        // Tạo dữ liệu giả lập cho scheduleService.getScheduleDetail
        ScheduleListResponse mockResponse = new ScheduleListResponse();
        // Thiết lập dữ liệu giả lập theo nhu cầu của bạn.

        Mockito.when(scheduleService.getScheduleDetail(userId, startDate, endDate)).thenReturn(mockResponse);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/schedules/" + userId)
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(MockMvcResultMatchers.status().isOk());
        // Kiểm tra nội dung của phản hồi nếu cần
    }
}
