package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.converter.SettingConverter;
import com.shsoftvina.erpshsoftvina.entity.Setting;
import com.shsoftvina.erpshsoftvina.enums.setting.CodeSettingEnum;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.SettingMapper;
import com.shsoftvina.erpshsoftvina.model.request.setting.SettingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.setting.SettingResponse;
import com.shsoftvina.erpshsoftvina.service.impl.SettingServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class SettingServiceTest {

    @InjectMocks
    private SettingServiceImpl service;

    @Mock
    private SettingMapper settingMapper;

    @Mock
    private SettingConverter settingConverter;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testFindAll() {
        List<Setting> settings = new ArrayList<>();


        settings.add(new Setting());
        settings.add(new Setting());
        SettingResponse response1 = new SettingResponse();
        SettingResponse response2 = new SettingResponse();
        List<SettingResponse> expectedResponse = Arrays.asList(response1, response2);

        Mockito.when(settingMapper.findAll()).thenReturn(settings);

        Mockito.when(settingConverter.toResponse(Mockito.any(Setting.class)))
                .thenReturn(response1)
                .thenReturn(response2);

        List<SettingResponse> result = service.findAll();
        assertEquals(expectedResponse, result);
    }

    @Test
    public void testFindById() {
        String settingId = "123";
        Setting setting = new Setting();

        SettingResponse mockResponse = new SettingResponse();

        Mockito.when(settingMapper.findById(settingId)).thenReturn(setting);
        Mockito.when(settingConverter.toResponse(Mockito.any(Setting.class))).thenReturn(mockResponse);

        SettingResponse result = service.findById(settingId);
        assertEquals(mockResponse, result);
    }

    @Test
    public void testUpdateSetting() {
        SettingUpdateRequest[] updateRequests = new SettingUpdateRequest[1];
        updateRequests[0] = new SettingUpdateRequest();
        updateRequests[0].setCode(CodeSettingEnum.BOOK.toString());

        Setting setting = new Setting();
        Mockito.when(settingMapper.findByCode(CodeSettingEnum.BOOK.toString())).thenReturn(setting);

        Mockito.when(settingMapper.updateSetting(Mockito.any(Setting.class))).thenReturn(1);

        int result = service.updateSetting(updateRequests);
        assertEquals(1, result);
    }

    @Test
    public void testUpdateSettingWithNotFound() {
        SettingUpdateRequest[] updateRequests = new SettingUpdateRequest[1];
        // Thiết lập các SettingUpdateRequest theo nhu cầu của bạn.

        // Thiết lập dữ liệu giả lập cho settingMapper.findByCode trả về null
        Mockito.when(settingMapper.findByCode(CodeSettingEnum.BOOK.toString())).thenReturn(null);

        NotFoundException exception = assertThrows(NotFoundException.class, () -> {
            service.updateSetting(updateRequests);
        });

        assertEquals("code", exception.getMessage());
    }
}