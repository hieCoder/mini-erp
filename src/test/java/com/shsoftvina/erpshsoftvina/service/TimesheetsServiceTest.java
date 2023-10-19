package com.shsoftvina.erpshsoftvina.service;
import com.shsoftvina.erpshsoftvina.api.ManagementTimeDayApi;
import com.shsoftvina.erpshsoftvina.converter.TimesheetsConverter;
import com.shsoftvina.erpshsoftvina.entity.Timesheets;
import com.shsoftvina.erpshsoftvina.mapper.TimesheetsMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.model.response.timesheets.TimesheetsResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.service.impl.TimesheetsServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

public class TimesheetsServiceTest {
    @InjectMocks
    private TimesheetsServiceImpl timesheetsService;

    @Mock
    private TimesheetsMapper timesheetsMapper;

    @Mock
    private TimesheetsConverter timesheetsConverter;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetTotalWorkDayByYear() {
        String userID = "sampleUserId";
        List<Map<String, ?>> mockData = new ArrayList<>();

        when(timesheetsMapper.totalWorkingDateByYear(userID)).thenReturn(mockData);

        List<Map<String, ?>> result = timesheetsService.getTotalWorkDayByYear(userID);

        assertEquals(mockData, result);
    }

    @Test
    public void testGetTotalWorkDayByMonth() {
        String userID = "sampleUserId";
        String year = "2023";

        List<Map<String, ?>> mockData = new ArrayList<>();

        when(timesheetsMapper.totalWorkingDateByMonth(userID, year)).thenReturn(mockData);

        List<Map<String, ?>> result = timesheetsService.getTotalWorkDayByMonth(userID, year);

        assertEquals(mockData, result);
    }
}
