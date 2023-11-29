package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.accounting.AccountResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accounting.PageAccountListResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.RemainBalanceEachMonth;

import java.time.LocalDate;
import java.util.List;
import java.util.concurrent.CompletableFuture;

public interface AccountingService {
    MonthHistoryList findAllMonthlyHistory();

    PageAccountListResponse findAccountingByMonth(Integer page, Integer size, LocalDate startTime, LocalDate endTime);

    int createAccounting(AccountingCreateRequest accountingCreateRequest);

    AccountResponse updateAccounting(AccountingUpdateRequest accountingCreateRequest);

    int deleteAccounting(String id);

    AccountResponse findAccountingById(String id);

    List<RemainBalanceEachMonth> getRemainBalanceEachMonth();
}

