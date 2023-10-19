package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.accounting.StatusAccountingEnum;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.accounting.AccountResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthYearFormat;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class AccountingConverter {
    @Autowired
    private UserConverter userConverter;

    public MonthHistoryList convertListToObjectDTO(List<MonthYearFormat> monthList) {
        return MonthHistoryList.builder()
                .monthList(monthList)
                .build();
    }

    public AccountResponse convertToResponseDTO(Accounting accounting) {
        Long expense = 0L, revenue = 0L;
        if (accounting.getExpense() < 0) {
            expense = accounting.getExpense();
        } else {
            revenue = accounting.getExpense();
        }
        String parseCreatedDate = DateUtils.formatLocalDateTime(accounting.getCreatedDate());
        return AccountResponse.builder()
                .id(accounting.getId())
                .bill(FileUtils.getPathUploadList(Accounting.class, accounting.getBill()))
                .createdDate(parseCreatedDate)
                .expense(expense)
                .remain(accounting.getRemain())
                .revenue(revenue)
                .user(userConverter.toAccountResponse(accounting.getUser()))
                .title(accounting.getTitle())
                .note(accounting.getNote())
                .build();
    }

    public List<AccountResponse> convertToListResponse(List<Accounting> accountingList) {
        return accountingList.stream().map(this::convertToResponseDTO).collect(Collectors.toList());
    }

    public Accounting convertToEntity(AccountingCreateRequest accountingCreateRequest, User user, Long latestRemain, LocalDateTime newDate, List<String> listFileNameSaveFileSuccess) {
        Long newRemain = latestRemain + accountingCreateRequest.getExpense();
        return Accounting.builder()
                .user(user)
                .title(accountingCreateRequest.getTitle())
                .remain(newRemain)
                .expense(accountingCreateRequest.getExpense())
                .createdDate(newDate)
                .id(ApplicationUtils.generateId())
                .bill(FileUtils.convertMultipartFileArrayToString(listFileNameSaveFileSuccess))
                .status(StatusAccountingEnum.ACTIVE)
                .note(accountingCreateRequest.getNote())
                .build();
    }

    public Accounting convertToEntity(AccountingUpdateRequest accountingUpdateRequest, User user, List<String> listFileNameSaveFileSuccess) {
        return Accounting.builder()
                .user(user)
                .title(accountingUpdateRequest.getTitle())
                .remain(accountingUpdateRequest.getRemain())
                .expense(accountingUpdateRequest.getExpense())
                .id(accountingUpdateRequest.getId())
                .bill(FileUtils.convertMultipartFileArrayToString(listFileNameSaveFileSuccess))
                .note(accountingUpdateRequest.getNote())
                .build();
    }

}

