package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.AccountingConstant;
import com.shsoftvina.erpshsoftvina.converter.AccountingConverter;
import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.exception.FileTooLimitedException;
import com.shsoftvina.erpshsoftvina.mapper.AccountingMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.accountings.AccountResponse;
import com.shsoftvina.erpshsoftvina.model.response.accountings.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accountings.PageAccountListResponse;
import com.shsoftvina.erpshsoftvina.model.response.accountings.TotalSpendAndRemain;
import com.shsoftvina.erpshsoftvina.service.AccountingService;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

@Service
public class AccountingServiceImpl implements AccountingService {
    @Autowired
    private AccountingMapper accountingMapper;
    @Autowired
    private AccountingConverter accountingConverter;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private HttpServletRequest request;

    @Override
    public MonthHistoryList findAllMonthlyHistory() {
        List<String> monthHistoryList = accountingMapper.findAllMonthlyHistory();
        return accountingConverter.convertListToObjectDTO(monthHistoryList);
    }

    @Override
    public PageAccountListResponse findAccountingByMonth(String monthId, Integer page, Integer size, LocalDate startTime, LocalDate endTime) {
        TotalSpendAndRemain totals = accountingMapper.getTotalSpending(monthId);
        if (totals == null) {
            return new PageAccountListResponse();
        }
        Long latestRemain = accountingMapper.getLatestRemain(monthId);
        totals.setTotalRemain(latestRemain);
        int offset = page * size;
        RowBounds rowBounds = new RowBounds(offset, size);
        LocalDateTime endDateWithTime = null;
        if (endTime != null) {
            endDateWithTime = endTime.atTime(23, 59, 59);
        }
        List<Accounting> accountingList = accountingMapper.findAccountingByMonth(monthId, rowBounds, startTime, endDateWithTime);
        List<AccountResponse> accountResponses = accountingConverter.convertToListResponse(accountingList);
        long totalRecordCount = accountingMapper.getTotalRecordCountPerMonth(monthId);
        long totalPage = (totalRecordCount + size - 1) / size;
        boolean hasNext = page < (totalPage - 1);
        boolean hasPrevious = page > 0;
        return new PageAccountListResponse(accountResponses, page, totalPage, hasNext, hasPrevious, totals);
    }

    @Override
    public int createAccounting(AccountingCreateRequest accountingCreateRequest) {
        if (accountingCreateRequest.getBill().length > AccountingConstant.NUMBER_FILE_LIMIT) {
            throw new FileTooLimitedException("Max file is 3");
        }
        LocalDateTime newDate = LocalDateTime.now();
        String formattedMonthYear = DateUtils.formatMonthYear(newDate);
        Long latestRemain = accountingMapper.getLatestRemain(formattedMonthYear);

        String uploadDir = AccountingConstant.UPLOAD_FILE_DIR;
        MultipartFile[] billFile = accountingCreateRequest.getBill();
        List listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, uploadDir, billFile);
        if (listFileNameSaveFileSuccess != null) {
            User currentUser = userMapper.findById(accountingCreateRequest.getUserId());
            Accounting accounting = accountingConverter.convertToEntity(accountingCreateRequest, currentUser, latestRemain, newDate);
            try {
                accountingMapper.createAccounting(accounting);
            } catch (Exception e) {
                FileUtils.deleteMultipleFilesToServer(request, uploadDir, accounting.getBill());
                return 0;
            }
            return 1;
        }
        return 0;

    }

    @Override
    public int updateAccounting(AccountingUpdateRequest accountingUpdateRequest) {
        if (accountingUpdateRequest.getBill().length > AccountingConstant.NUMBER_FILE_LIMIT) {
            throw new FileTooLimitedException("Max file is 3");
        }
        String dir = AccountingConstant.UPLOAD_FILE_DIR;
        List listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, accountingUpdateRequest.getBill());
        Accounting currentAccounting = accountingMapper.findAccountingById(accountingUpdateRequest.getId());
        User currentUser = userMapper.findById(accountingUpdateRequest.getUserId());
        if (listFileNameSaveFileSuccess != null) {
            Accounting updateAccounting = accountingConverter.convertToEntity(accountingUpdateRequest, currentUser);
            try {
                accountingMapper.updateAccounting(updateAccounting);
                if (!Objects.equals(currentAccounting.getExpense(), accountingUpdateRequest.getExpense())) {
                    Accounting beforeCurrentAccounting = accountingMapper.findBeforeCurrentAccounting(currentAccounting);
                    List<Accounting> remainRecordInMonthList = accountingMapper.getRemainRecordInMonth(currentAccounting);
                    Long beforeRemain = 0L;
                    if (beforeCurrentAccounting != null) {
                        beforeRemain = beforeCurrentAccounting.getRemain();
                    }
                    for (Accounting accounting : remainRecordInMonthList) {
                        beforeRemain += accounting.getExpense();
                        accounting.setRemain(beforeRemain);
                    }
                    accountingMapper.updateRecordsBatch(remainRecordInMonthList);
                    return 1;
                }
            } catch (Exception e) {
                FileUtils.deleteMultipleFilesToServer(request, dir, updateAccounting.getBill());
                return 0;
            }
            return 1;
        }
        return 0;
    }

    @Override
    public int deleteAccounting(String id) {
        Accounting deleteAccounting = accountingMapper.findAccountingById(id);
        accountingMapper.deleteAccounting(id);

        return 0;
    }

}

