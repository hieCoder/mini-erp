package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.model.request.weeklyreport.CreateWeeklyReportRequest;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.PageWeeklyReportListRespone;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportDetailResponse;
import com.shsoftvina.erpshsoftvina.service.WeeklyReportService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;

public class WeeklyReportApiTest {

    @InjectMocks
    private WeeklyReportApi weeklyReportApi;

    @Mock
    private WeeklyReportService weeklyReportService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }


    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this); // Khởi tạo các mock
        weeklyReportApi = new WeeklyReportApi();
        weeklyReportApi.weeklyReportService = weeklyReportService;
    }

//    Cannot invoke "org.springframework.security.core.Authentication.getPrincipal()
//    @Test
//    public void testGetAllWeeklyReport() {
//        String search = "sample search";
//        int page = 1;
//        int pageSize = 10;
//        User user = new User();
//        user.setRole(RoleEnum.OWNER);
//        user.setId("1");
//
//        PageWeeklyReportListRespone mockResponse = new PageWeeklyReportListRespone();
//
//        when(weeklyReportService.getAllWeeklyReport(eq(search), eq(user.getRole().getValue()), eq(user.getId()), eq(page), eq(pageSize)))
//                .thenReturn(mockResponse);
//
//        ResponseEntity<?> responseEntity = weeklyReportApi.getAllWeeklyReport(search, page, pageSize);
//
//        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
//        assertEquals(mockResponse, responseEntity.getBody());
//    }

    @Test
    public void testGetDetail() {
        String reportId = "1";

        WeeklyReportDetailResponse weeklyReport = new WeeklyReportDetailResponse();

        when(weeklyReportService.findById(reportId))
                .thenReturn(weeklyReport);

        ResponseEntity<?> responseEntity = weeklyReportApi.getDetail(reportId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(weeklyReport, responseEntity.getBody());
    }

    @Test
    public void testCreateWeeklyReport() {
        CreateWeeklyReportRequest createWeeklyReportRequest = new CreateWeeklyReportRequest();
        createWeeklyReportRequest.setTitle("hello");
        createWeeklyReportRequest.setContent("don't hello with me!");
        createWeeklyReportRequest.setUserId("1");

        when(weeklyReportService.createWeeklyReport(createWeeklyReportRequest))
                .thenReturn(1);

        ResponseEntity<?> responseEntity = weeklyReportApi.createWeeklyReport(createWeeklyReportRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, responseEntity.getBody());
    }

}
