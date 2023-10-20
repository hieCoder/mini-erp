package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.converter.WeeklyReportConverter;
import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import com.shsoftvina.erpshsoftvina.mapper.WeeklyReportMapper;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.PageWeeklyReportListRespone;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.WeeklyReportShowResponse;
import com.shsoftvina.erpshsoftvina.service.impl.WeeklyReportServiceImpl;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import org.apache.ibatis.session.RowBounds;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

public class WeeklyReportServiceTest {

    @InjectMocks
    private WeeklyReportServiceImpl weeklyReport;

    @Mock
    private WeeklyReportMapper weeklyReportMapper;

    @Mock
    private WeeklyReportConverter weeklyReportConverter;

    @Mock
    private ApplicationUtils applicationUtils;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetAllWeeklyReport() {
        // Create sample input parameters
        String searchTerm = "sampleSearch";
        String userRole = "USER_ROLE";
        String userId = "user123";
        int start = 1;
        int pageSize = 10;

        // Create mock data for weeklyReportMapper and weeklyReportConverter
        List<WeeklyReport> mockWeeklyReports = Arrays.asList(new WeeklyReport(), new WeeklyReport());
        when(weeklyReportMapper.getAllWeeklyReport(eq(searchTerm), eq(userRole), eq(userId), any(RowBounds.class))).thenReturn(mockWeeklyReports);

        List<WeeklyReportShowResponse> mockShowResponses = Arrays.asList(new WeeklyReportShowResponse(), new WeeklyReportShowResponse());
        when(weeklyReportConverter.toListShowWeeklyReportResponse(mockWeeklyReports)).thenReturn(mockShowResponses);

        long totalRecordCount = 20L;
        when(weeklyReportMapper.getTotalWeeklyReport(searchTerm, userRole, userId)).thenReturn(totalRecordCount);

        PageWeeklyReportListRespone response = weeklyReport.getAllWeeklyReport(searchTerm, userRole, userId, start, pageSize);

        // Verify
        verify(weeklyReportMapper).getAllWeeklyReport(eq(searchTerm), eq(userRole), eq(userId), any(RowBounds.class));
        verify(weeklyReportConverter).toListShowWeeklyReportResponse(mockWeeklyReports);
        verify(weeklyReportMapper).getTotalWeeklyReport(searchTerm, userRole, userId);

        // Assertions
        assertTrue(response.getListWeeklyReport().size() != 0);
    }

//    @Test
//    public void testFindById() {
//        // Create a sample ID
//        String id = "1";
//
//        // Create a mock WeeklyReport
//        WeeklyReport mockWeeklyReport = new WeeklyReport();
//        when(weeklyReportMapper.findById(id)).thenReturn(mockWeeklyReport);
//        when(weeklyReport.findById(id)).thenReturn(new WeeklyReportDetailResponse());
//        // Mock the user ID
//        doNothing().when(applicationUtils).checkUserAllow(anyString());
//
//        // Verify that the methods were called with the expected parameters
////        verify(weeklyReportMapper).findById(mockWeeklyReport.getId());
//        verify(applicationUtils).checkUserAllow(mockWeeklyReport.getId());
//
//        // Assertions
//        assertEquals(weeklyReport.findById(id), mockWeeklyReport);
//    }
}
