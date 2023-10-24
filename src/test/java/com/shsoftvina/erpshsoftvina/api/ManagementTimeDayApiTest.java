package com.shsoftvina.erpshsoftvina.api;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.DayUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import liquibase.pro.packaged.A;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

public class ManagementTimeDayApiTest {

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @InjectMocks
    private ManagementTimeDayApi managementTimeDayApi;

    @Mock
    private ManagementTimeDayService managementTimeDayService;

    @Test
    public void testCreateDay() {
        DayCreateRequest request = new DayCreateRequest();
        when(managementTimeDayService.createDay(request)).thenReturn(new DayResponse());

        ResponseEntity<?> responseEntity = managementTimeDayApi.createDay(request);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testUpdateDay() {
        DayUpdateRequest request = new DayUpdateRequest();

        when(managementTimeDayService.updateDay(request)).thenReturn(new DayResponse());

        ResponseEntity<?> responseEntity = managementTimeDayApi.updateDay(request);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testGetDay() {
        String id = "sampleId";

        when(managementTimeDayService.findById(id)).thenReturn(new DayResponse());

        ResponseEntity<?> responseEntity = managementTimeDayApi.getDay(id);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testGetDaysByMonthAndYear() {
        String userId = "sampleUserId";
        String startDate = "2023-01-01";
        String endDate = "2023-01-31";

        when(managementTimeDayService.getDays(userId, startDate, endDate)).thenReturn(new ArrayList<>());

        ResponseEntity<?> responseEntity = managementTimeDayApi.getDays(endDate, startDate, userId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }
}
