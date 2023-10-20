package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.controller.AccountingController;
import com.shsoftvina.erpshsoftvina.model.response.accounting.AccountResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthYearFormat;
import com.shsoftvina.erpshsoftvina.model.response.accounting.PageAccountListResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.TotalSpendAndRemain;
import com.shsoftvina.erpshsoftvina.model.response.user.UserAccountingResponse;
import com.shsoftvina.erpshsoftvina.service.AccountingService;
import com.shsoftvina.erpshsoftvina.service.impl.AccountingServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.web.WebAppConfiguration;

import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.contains;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.hasProperty;
import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.nullValue;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

@WebAppConfiguration
public class AccountingControllerTest {
    private final AccountingService accountingService = Mockito.mock(AccountingServiceImpl.class);
    private MockMvc mockMvc;
    @InjectMocks
    private AccountingController accountingController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(accountingController).build();
    }

    @Test
    public void findAllTest() throws Exception {
        List<AccountResponse> accountResponseList = new ArrayList<>();
        String input = "231002121630-Accounting Management Interface.xlsx";
        String[] result = input.split("-");
        accountResponseList.add(new AccountResponse("4b90a870-5ffa-4ea1-a100-63215ce9a02e", "27/07/2023 14:14:43", 20000L, 0L, 20000L, new UserAccountingResponse("4", "Thằng Hiếu phá thế"), result, "Buy watermelon", "note1"));
        accountResponseList.add(new AccountResponse("111ec17d-3921-4bf7-8fcd-283d2fc8d0ec", "27/07/2023 14:14:46", 100000L, 0L, 120000L, new UserAccountingResponse("3", "TrungHieu99999"), null, "Buy Rice", "note2"));
        PageAccountListResponse firstAccounting = new PageAccountListResponse(accountResponseList, 1, 1, 5, false, false, new TotalSpendAndRemain(120000L, 0L, 120000L));
        when(accountingService.findAccountingByMonth("2023-07", 1, 5, null, null)).thenReturn(firstAccounting);

        mockMvc.perform(get("/accounting/{monthId}", "2023-07"))
                .andExpect(status().isOk())
                .andExpect(view().name("accounting/homepage"))
                .andExpect(forwardedUrl("accounting/homepage"))
                .andExpect(model().attributeExists("list"))
                .andExpect(model().attribute("list", hasProperty("accountResponseList", hasSize(2))))
                .andExpect(model().attribute("list", hasProperty("accountResponseList", hasItem(
                        allOf(
                                hasProperty("id", is("4b90a870-5ffa-4ea1-a100-63215ce9a02e")),
                                hasProperty("createdDate", is("27/07/2023 14:14:43")),
                                hasProperty("revenue", is(20000L)),
                                hasProperty("expense", is(0L)),
                                hasProperty("remain", is(20000L)),
                                hasProperty("user", hasProperty("id", is("4"))),
                                hasProperty("bill", is(result)),
                                hasProperty("title", is("Buy watermelon")),
                                hasProperty("note", is("note1"))

                        )))))
                .andExpect(model().attribute("list", hasProperty("accountResponseList", hasItem(
                        allOf(
                                hasProperty("id", is("111ec17d-3921-4bf7-8fcd-283d2fc8d0ec")),
                                hasProperty("createdDate", is("27/07/2023 14:14:46")),
                                hasProperty("revenue", is(100000L)),
                                hasProperty("expense", is(0L)),
                                hasProperty("remain", is(120000L)),
                                hasProperty("user", hasProperty("id", is("3"))),
                                hasProperty("bill", nullValue()),
                                hasProperty("title", is("Buy Rice")),
                                hasProperty("note", is("note2"))

                        )))));
        verify(accountingService, times(1)).findAccountingByMonth("2023-07", 1, 5, null, null);
        verifyNoMoreInteractions(accountingService);
    }

//    @Test
//    public void findAllMonthlyHistoryTest() throws Exception {
//        List<MonthYearFormat> monthList = new ArrayList<>();
//        monthList.add(new MonthYearFormat("2023", Arrays.asList("2023-10", "2023-09", "2023-08", "2023-07")));
//        monthList.add(new MonthYearFormat("2022", Arrays.asList("2022-10", "2022-09", "2022-08", "2022-07")));
//        MonthHistoryList monthHistoryList = new MonthHistoryList(monthList);
//        when(accountingService.findAllMonthlyHistory()).thenReturn(monthHistoryList);
//
//        mockMvc.perform(get("/accounting"))
//                .andExpect(status().isOk())
//                .andExpect(view().name("accounting/total-month"))
//                .andExpect(forwardedUrl("accounting/total-month"))
//                .andExpect(model().attributeExists("monthList"))
//                .andExpect(model().attribute("monthList", allOf(
//                        hasProperty("monthList", hasSize(2)),
//                        hasProperty("monthList", hasItem(
//                                allOf(
//                                        hasProperty("year", is("2023")),
//                                        hasProperty("month", contains("2023-10", "2023-09", "2023-08", "2023-07"))
//                                )
//                        )),
//                        hasProperty("monthList", hasItem(
//                                allOf(
//                                        hasProperty("year", is("2022")),
//                                        hasProperty("month", contains("2022-10", "2022-09", "2022-08", "2022-07"))
//                                )
//                        ))
//                )));
//
//        verify(accountingService, times(1)).findAllMonthlyHistory();
//        verifyNoMoreInteractions(accountingService);
//    }
//
//    @Test
//    public void showAccountingDetail() throws Exception {
//        String input = "231013144551-휴가 신청서_VONG_TUYEN_LAM.xlsx";
//        String[] result = input.split("-");
//        AccountResponse accountResponse = new AccountResponse("0aa291bc-1e67-4df8-b83d-158e159de09e", "2023-10-13 14:45:51", 0L, -4254L, -389123L, new UserAccountingResponse("3", "TrungHieu99999"), result, "test", "abcxyz");
//        when(accountingService.findAccountingById("0aa291bc-1e67-4df8-b83d-158e159de09e")).thenReturn(accountResponse);
//
//        mockMvc.perform(get("/accounting/detail/{id}", "0aa291bc-1e67-4df8-b83d-158e159de09e"))
//                .andExpect(status().isOk())
//                .andExpect(view().name("accounting/detail"))
//                .andExpect(forwardedUrl("accounting/detail"))
//                .andExpect(model().attributeExists("account"))
//                .andExpect(model().attribute("account",
//                        allOf(
//                                hasProperty("id", is("0aa291bc-1e67-4df8-b83d-158e159de09e")),
//                                hasProperty("createdDate", is("2023-10-13 14:45:51")),
//                                hasProperty("revenue", is(0L)),
//                                hasProperty("expense", is(-4254L)),
//                                hasProperty("remain", is(-389123L)),
//                                hasProperty("user", allOf(
//                                        hasProperty("id", is("3")),
//                                        hasProperty("fullname", is("TrungHieu99999"))
//                                )),                                hasProperty("bill", is(result)),
//                                hasProperty("title", is("test")),
//                                hasProperty("note", is("abcxyz"))
//                        )
//                ));
//    }
}
