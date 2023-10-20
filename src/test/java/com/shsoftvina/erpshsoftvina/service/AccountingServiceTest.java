package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.converter.AccountingConverter;
import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.accounting.StatusAccountingEnum;
import com.shsoftvina.erpshsoftvina.mapper.AccountingMapper;
import com.shsoftvina.erpshsoftvina.model.response.accounting.AccountResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthYearFormat;
import com.shsoftvina.erpshsoftvina.model.response.user.UserAccountingResponse;
import com.shsoftvina.erpshsoftvina.service.impl.AccountingServiceImpl;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.junit.jupiter.api.AfterEach;
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
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.verify;
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

    @AfterEach
    public void resetMocks() {
        Mockito.reset(accountingMapper);
    }

//    @Test
//    void findAllMonthlyHistory() {
//        List<MonthYearFormat> monthList = new ArrayList<>();
//        monthList.add(new MonthYearFormat("2023", Arrays.asList("2023-10", "2023-09", "2023-08", "2023-07")));
//        monthList.add(new MonthYearFormat("2022", Arrays.asList("2022-10", "2022-09", "2022-08", "2022-07")));
//        when(accountingMapper.findAllMonthlyHistory()).thenReturn(monthList);
//        when(accountingConverter.convertListToObjectDTO(monthList)).thenReturn(new MonthHistoryList(monthList));
//        MonthHistoryList monthListActual = accountingService.findAllMonthlyHistory();
//        assertEquals(monthList, monthListActual.getMonthList());
//    }
//
//    @Test
//    void findAccountingByMonth() {
//
//    }
//
//    @Test
//    void createAccounting() {
//
//    }
//
//    @Test
//    void updateAccounting() {
//
//    }
//
//    @Test
//    void deleteAccounting() {
//
//    }
//
//    @Test
//    void findAccountingById() {
//        Accounting accounting = new Accounting("111ec17d-3921-4bf7-8fcd-283d2fc8d0ec", DateUtils.toLocalDateTime("2023-07-27 14:14:46"), 100000L, 120000L, new User(), null, "Buy Rice", StatusAccountingEnum.ACTIVE, "abcxyz");
//        AccountResponse accountResponse = accountingConverter.convertToResponseDTO(accounting);
//        when(accountingMapper.findAccountingById("111ec17d-3921-4bf7-8fcd-283d2fc8d0ec")).thenReturn(accounting);
//        when(accountingConverter.convertToResponseDTO(accounting)).thenReturn(accountResponse);
//        AccountResponse actual = accountingService.findAccountingById("111ec17d-3921-4bf7-8fcd-283d2fc8d0ec");
//        verify(accountingMapper).findAccountingById("111ec17d-3921-4bf7-8fcd-283d2fc8d0ec");
//        assertEquals(accountResponse, actual);
//    }

}
