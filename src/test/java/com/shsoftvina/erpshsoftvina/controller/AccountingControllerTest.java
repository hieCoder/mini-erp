package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.model.response.accountings.PageAccountListResponse;
import com.shsoftvina.erpshsoftvina.service.AccountingService;
import com.shsoftvina.erpshsoftvina.service.impl.AccountingServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.Arrays;

import static org.hamcrest.Matchers.*;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

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
        Accounting firstAccounting = new Accounting();
        Accounting secondAccounting = new Accounting();
        when(accountingService.findAccountingByMonth("2023-10",null,null,null,null)).thenReturn((PageAccountListResponse) Arrays.asList(firstAccounting,secondAccounting));

        mockMvc.perform(get("/"))
                .andExpect(status().isOk())
                .andExpect(view().name("/accounting/list"))
                .andExpect(forwardedUrl("/accounting/list"))
                .andExpect(model().attribute("customers", hasSize(2)))
                .andExpect(model().attribute("customers", hasItem(
                        allOf(
                                hasProperty("id", is(1)),
                                hasProperty("firstName", is("Nguyen")),
                                hasProperty("lastName", is("Tung"))
                        ))))
                .andExpect(model().attribute("customers", hasItem(
                        allOf(
                                hasProperty("id", is(2)),
                                hasProperty("firstName", is("Hoang")),
                                hasProperty("lastName", is("Nam"))
                        ))));
        verify(accountingService, times(1)).findAccountingByMonth("2023-10",null,null,null,null);
        verifyNoMoreInteractions(accountingService);
    }
}
