package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.accountings.AccountingCreateRequest;
import com.hieDev.minierp.model.request.accountings.AccountingUpdateRequest;
import com.hieDev.minierp.model.response.accounting.AccountResponse;
import com.hieDev.minierp.model.response.accounting.MonthHistoryList;
import com.hieDev.minierp.model.response.accounting.PageAccountListResponse;
import com.hieDev.minierp.model.response.accounting.RemainBalanceEachMonth;

import java.time.LocalDate;
import java.util.List;

public interface AccountingService {
    MonthHistoryList findAllMonthlyHistory();

    PageAccountListResponse findAccountingByMonth(Integer page, Integer size, LocalDate startTime, LocalDate endTime);

    int createAccounting(AccountingCreateRequest accountingCreateRequest);

    AccountResponse updateAccounting(AccountingUpdateRequest accountingCreateRequest);

    int deleteAccounting(String id);

    AccountResponse findAccountingById(String id);

    List<RemainBalanceEachMonth> getRemainBalanceEachMonth();
}

