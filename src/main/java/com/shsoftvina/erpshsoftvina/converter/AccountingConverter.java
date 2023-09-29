package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.model.response.accountings.AccountResponse;
import com.shsoftvina.erpshsoftvina.model.response.accountings.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class AccountingConverter {
    public MonthHistoryList convertListToObjectDTO(List<String> monthList) {
        return MonthHistoryList.builder()
                .monthList(monthList)
                .build();
    }

    public AccountResponse convertToResponseDTO(Accounting accounting) {
        Integer expense = 0;
        Integer revenue = 0;
        if (accounting.getExpense() < 0) {
            expense = accounting.getExpense();
        } else {
            revenue =accounting.getExpense();
        }
        LocalDateTime createdDate = accounting.getCreatedDate();
        String parseCreatedDate = DateUtils.formatLocalDateTime(createdDate);
        return AccountResponse.builder()
                .id(accounting.getId())
                .bill(accounting.getBill())
                .createdDate(parseCreatedDate)
                .expense(expense)
                .remain(accounting.getRemain())
                .revenue(revenue)
                .username(accounting.getUser().getUsername())
                .build();
    }
    public List<AccountResponse> convertToListResponse(List<Accounting> accountingList) {
        return accountingList.stream().map(this::convertToResponseDTO).collect(Collectors.toList());
    }
}
