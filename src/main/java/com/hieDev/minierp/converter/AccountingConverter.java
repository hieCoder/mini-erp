package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.Accounting;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.enums.accounting.StatusAccountingEnum;
import com.hieDev.minierp.model.request.accountings.AccountingCreateRequest;
import com.hieDev.minierp.model.request.accountings.AccountingUpdateRequest;
import com.hieDev.minierp.model.response.accounting.AccountResponse;
import com.hieDev.minierp.model.response.accounting.MonthHistoryList;
import com.hieDev.minierp.model.response.accounting.MonthYearFormat;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.DateUtils;
import com.hieDev.minierp.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
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
        String parsePayDate = DateUtils.formatLocalDateTime(accounting.getPayDate());
        return AccountResponse.builder()
                .id(accounting.getId())
                .bill(FileUtils.getPathUploadList(Accounting.class, accounting.getBill()))
                .createdDate(parseCreatedDate)
                .expense(expense)
                .remain(accounting.getRemain())
                .revenue(revenue)
                .user(userConverter.toIdAndFullnameUserResponse(accounting.getUser()))
                .title(accounting.getTitle())
                .note(accounting.getNote())
                .payDate(parsePayDate)
                .build();
    }

    public List<AccountResponse> convertToListResponse(List<Accounting> accountingList) {
        return accountingList.stream().map(this::convertToResponseDTO).collect(Collectors.toList());
    }

    public Accounting convertToEntity(AccountingCreateRequest accountingCreateRequest, User user, Long latestRemain, List<String> listFileNameSaveFileSuccess) {
        Long newRemain = latestRemain + accountingCreateRequest.getExpense();
        return Accounting.builder()
                .user(user)
                .title(accountingCreateRequest.getTitle())
                .remain(newRemain)
                .expense(accountingCreateRequest.getExpense())
                .id(ApplicationUtils.generateId())
                .bill(FileUtils.convertMultipartFileArrayToString(listFileNameSaveFileSuccess))
                .status(StatusAccountingEnum.ACTIVE)
                .note(accountingCreateRequest.getNote())
                .payDate(DateUtils.toLocalDateTime(accountingCreateRequest.getPayDate()))
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
                .payDate(DateUtils.toLocalDateTime(accountingUpdateRequest.getPayDate()))
                .build();
    }

}

