package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.converter.AccountingConverter;
import com.shsoftvina.erpshsoftvina.mapper.AccountingMapper;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.service.impl.AccountingServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

@WebAppConfiguration
public class AccountingServiceTest {
    @Mock
    private AccountingMapper accountingMapper;
    private final AccountingConverter accountingConverter = Mockito.mock(AccountingConverter.class);
    private MockMvc mockMvc;
    @InjectMocks
    private AccountingServiceImpl accountingService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(accountingService).build();
    }

//    @Test
//     void findAllMonthlyHistory() {
//        List<String> monthList = new ArrayList<>();
//        monthList.add("2023-10");
//        monthList.add("2023-09");
//        monthList.add("2023-08");
//        monthList.add("2023-07");
//        when(accountingMapper.findAllMonthlyHistory()).thenReturn(monthList);
//        when(accountingConverter.convertListToObjectDTO(monthList)).thenReturn(new MonthHistoryList(monthList));
//        MonthHistoryList monthListActual = accountingService.findAllMonthlyHistory();
//        assertEquals(monthList,monthListActual.getMonthList());
//    }
}
