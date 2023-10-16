package com.shsoftvina.erpshsoftvina.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shsoftvina.erpshsoftvina.api.AccountingApi;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.accounting.AccountResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accounting.PageAccountListResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.TotalSpendAndRemain;
import com.shsoftvina.erpshsoftvina.model.response.user.UserAccountingResponse;
import com.shsoftvina.erpshsoftvina.service.AccountingService;
import com.shsoftvina.erpshsoftvina.service.impl.AccountingServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentMatchers;
import org.mockito.InjectMocks;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.http.MediaType;
import org.springframework.test.context.web.WebAppConfiguration;

import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.Matchers.contains;
import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.is;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;

@WebAppConfiguration
public class AccountingControllerTest {
    private final AccountingService accountingService = Mockito.mock(AccountingServiceImpl.class);
    private MockMvc mockMvc;
    @InjectMocks
    private AccountingApi accountingController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(accountingController).build();
    }

    @Test
    public void findAllTest() throws Exception {
        List<AccountResponse> accountResponseList = new ArrayList<>();
        accountResponseList.add(new AccountResponse("4b90a870-5ffa-4ea1-a100-63215ce9a02e", "27/07/2023 14:14:43", 20000L, 0L, 20000L, new UserAccountingResponse("4", "Thằng Hiếu phá thế"), "231002121630-Accounting Management Interface.xlsx", "Buy watermelon"));
        accountResponseList.add(new AccountResponse("111ec17d-3921-4bf7-8fcd-283d2fc8d0ec", "27/07/2023 14:14:46", 100000L, 0L, 120000L, new UserAccountingResponse("3", "TrungHieu99999"), null, "Buy Rice"));
        PageAccountListResponse firstAccounting = new PageAccountListResponse(accountResponseList, 1, 1, 5, false, false, new TotalSpendAndRemain(120000L, 0L, 120000L));
        when(accountingService.findAccountingByMonth("2023-07", 1, 5, null, null)).thenReturn(firstAccounting);

        mockMvc.perform(get("/api/v1/accounts/{monthId}", "2023-07"))
                .andExpect(status().isOk())
//                .andExpect(view().name("/accounting/list"))
//                .andExpect(forwardedUrl("/accounting/list"))
                .andExpect(jsonPath("$.accountResponseList", hasSize(2)))
                // Kiểm tra các thuộc tính khác trong kết quả
                .andExpect(jsonPath("$.totalList.totalRevenue", is(120000)))
                .andExpect(jsonPath("$.totalList.totalExpense", is(0)))
                .andExpect(jsonPath("$.totalList.totalRemain", is(120000)));
        verify(accountingService, times(1)).findAccountingByMonth("2023-07", 1, 5, null, null);
        verifyNoMoreInteractions(accountingService);
    }

//    @Test
//    public void findAllMonthlyHistoryTest() throws Exception {
//        List<String> monthList = new ArrayList<>();
//        monthList.add("2023-10");
//        monthList.add("2023-09");
//        monthList.add("2023-08");
//        monthList.add("2023-07");
//        MonthHistoryList monthHistoryList = new MonthHistoryList(monthList);
//        when(accountingService.findAllMonthlyHistory()).thenReturn(monthHistoryList);
//
//        mockMvc.perform(get("/api/v1/accounts/"))
//                .andExpect(status().isOk())
//                .andExpect(jsonPath("$.monthList", hasSize(4)))
//                .andExpect(jsonPath("$.monthList", containsInAnyOrder("2023-10", "2023-09", "2023-08", "2023-07")))
//                .andExpect(jsonPath("$.monthList", contains("2023-10", "2023-09", "2023-08", "2023-07")))
//                .andExpect(jsonPath("$.monthList[0]", is("2023-10")));
//        verify(accountingService, times(1)).findAllMonthlyHistory();
//        verifyNoMoreInteractions(accountingService);
//    }
    @Test
    public void createAccountingTest() throws Exception {
        AccountingCreateRequest accountingUpdateRequest = new AccountingCreateRequest(20000L,"4",new MultipartFile[]{},"Buy watermelon");
        ObjectMapper objectMapper = new ObjectMapper();
        String requestBody = objectMapper.writeValueAsString(accountingUpdateRequest);
        when(accountingService.createAccounting(ArgumentMatchers.any(AccountingCreateRequest.class))).thenReturn(1);

        mockMvc.perform(post("/api/v1/accounts")
                .contentType(MediaType.APPLICATION_JSON)
                .content(requestBody))
                .andExpect(status().isCreated());
        verify(accountingService, times(1)).createAccounting(ArgumentMatchers.any(AccountingCreateRequest.class));
    }

//    @Test
//    public void updateAccountingTest() throws Exception {
//        AccountingUpdateRequest accountingUpdateRequest = new AccountingUpdateRequest("4b90a870-5ffa-4ea1-a100-63215ce9a02e",20000L,20000L,"4",new MultipartFile[]{},"Buy watermelon");
//        ObjectMapper objectMapper = new ObjectMapper();
//        String requestBody = objectMapper.writeValueAsString(accountingUpdateRequest);
//        when(accountingService.updateAccounting(ArgumentMatchers.any(AccountingUpdateRequest.class))).thenReturn(1);
//
//        mockMvc.perform(post("/api/v1/accounts/edit")
//                .contentType(MediaType.APPLICATION_JSON)
//                .content(requestBody))
//                .andExpect(status().isFound());
//        verify(accountingService, times(1)).updateAccounting(ArgumentMatchers.any(AccountingUpdateRequest.class));
//    }

    @Test
    public void deleteAccountingTest() throws Exception {
        when(accountingService.deleteAccounting("1")).thenReturn(1);

        mockMvc.perform(delete("/api/v1/accounts/{id}", "1"))
                .andExpect(status().isOk());
        verify(accountingService, times(1)).deleteAccounting("1");
    }
}
