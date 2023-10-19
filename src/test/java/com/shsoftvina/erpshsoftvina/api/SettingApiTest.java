package com.shsoftvina.erpshsoftvina.api;
import com.shsoftvina.erpshsoftvina.api.SettingApi;
import com.shsoftvina.erpshsoftvina.model.request.setting.SettingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.setting.SettingResponse;
import com.shsoftvina.erpshsoftvina.service.SettingService;
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

public class SettingApiTest {

    @InjectMocks
    private SettingApi settingApi;

    @Mock
    private SettingService settingService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testFindAll() {
        when(settingService.findAll()).thenReturn(new ArrayList<>());

        ResponseEntity<?> responseEntity = settingApi.findAll();

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testFindById() {
        String settingId = "sampleSettingId";


        when(settingService.findById(settingId)).thenReturn(new SettingResponse());

        ResponseEntity<?> responseEntity = settingApi.findById(settingId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }

    @Test
    public void testUpdateSetting() {
        SettingUpdateRequest[] requestArray = new SettingUpdateRequest[1];

        when(settingService.updateSetting(requestArray)).thenReturn(1);

        ResponseEntity<?> responseEntity = settingApi.updateSetting(requestArray);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }
}