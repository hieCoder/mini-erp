package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.accountings.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accountings.PageAccountListResponse;

import java.time.LocalDate;

public interface AccountingService {
    MonthHistoryList findAllMonthlyHistory();

    PageAccountListResponse findAccountingByMonth(String monthId, Integer page, Integer size, LocalDate startTime, LocalDate endTime);

    int createAccounting(AccountingCreateRequest accountingCreateRequest);

    int updateAccounting(AccountingUpdateRequest accountingCreateRequest);
}

