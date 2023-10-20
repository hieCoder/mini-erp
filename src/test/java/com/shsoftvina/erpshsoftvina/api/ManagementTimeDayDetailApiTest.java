package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtimedetail.DayDetailResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayDetailService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.mockito.Mockito.when;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class ManagementTimeDayDetailApiTest {

    @InjectMocks
    private ManagementTimeDayDetailApi managementTimeDayDetailApi;

    @Mock
    private ManagementTimeDayDetailService managementTimeDayDetailService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testFindByManagementTimeDayId() {
        String id = "1";
        String code = "A";
        String[] data = {"data1", "data2"};

        when(managementTimeDayDetailService.findByManagementTimeDayId(id, code)).thenReturn(new DayDetailResponse(id, data));

        ResponseEntity<?> responseEntity = managementTimeDayDetailApi.findByManagementTimeDayId(id, code);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(new DayDetailResponse(id, data), responseEntity.getBody());
    }

    @Test
    public void testIsExist() {
        String id = "1";

        when(managementTimeDayDetailService.findByManagementTimeDayId(id)).thenReturn(true);

        ResponseEntity<?> responseEntity = managementTimeDayDetailApi.isExist(id);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(true, responseEntity.getBody());
    }

    @Test
    public void testCreateDay() {
        DayDetailCreateRequest dayDetailCreateRequest = new DayDetailCreateRequest();
        String dayId = "1";
        String code = "A";
        String[] data = {"2","3","4","5","6"};
        dayDetailCreateRequest.setDayId(dayId);
        dayDetailCreateRequest.setCode(code);
        dayDetailCreateRequest.setData(data);

        when(managementTimeDayDetailService.createTimeDayDetail(dayDetailCreateRequest)).thenReturn(1);
        ResponseEntity<?> responseEntity = managementTimeDayDetailApi.createDay(dayDetailCreateRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, responseEntity.getBody());
    }

    @Test
    public void testUpdateDay() {

        DayDetailUpdateRequest dayDetailUpdateRequest = new DayDetailUpdateRequest();
        String dayId = "1";
        String code = "A";
        String[] data = {"2","3","4","5","6"};
        dayDetailUpdateRequest.setDayId(dayId);
        dayDetailUpdateRequest.setCode(code);
        dayDetailUpdateRequest.setData(data);

        when(managementTimeDayDetailService.updateTimeDayDetail(dayDetailUpdateRequest)).thenReturn(1);
        ResponseEntity<?> responseEntity = managementTimeDayDetailApi.updateDay(dayDetailUpdateRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, responseEntity.getBody());
    }
}
