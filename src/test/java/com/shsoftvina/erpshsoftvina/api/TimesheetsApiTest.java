package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.service.TimesheetsService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.ArrayList;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

public class TimesheetsApiTest {


    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @InjectMocks
    private TimesheetsApi timesheetsApi;

    @Mock
    private TimesheetsService timesheetsService;

    @Test
    public void testGetTotalWorkingDate() {
        String userID = "sampleUserId";
        String year = null;
        when(timesheetsService.getTotalWorkDayByYear(userID)).thenReturn(new ArrayList<>());

        when(timesheetsService.getTotalWorkDayByMonth(userID, year)).thenReturn(new ArrayList<>());

        ResponseEntity<?> responseEntity = timesheetsApi.getTotalWorkingDate(userID, year);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testGetTotalWorkingDateWithYear() {
        String userID = "sampleUserId";
        String year = "2023";

        when(timesheetsService.getTotalWorkDayByMonth(userID, year)).thenReturn(new ArrayList<>());

        ResponseEntity<?> responseEntity = timesheetsApi.getTotalWorkingDate(userID, year);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testGetTotalWorkingDateWithoutYear() {
        String userID = "sampleUserId";

        when(timesheetsService.getTotalWorkDayByYear(userID)).thenReturn(new ArrayList<>());

        ResponseEntity<?> responseEntity = timesheetsApi.getTotalWorkingDate(userID, null);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }
}
