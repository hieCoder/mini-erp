package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.AccountingConstant;
import com.shsoftvina.erpshsoftvina.converter.AccountingConverter;
import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.AccountingMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.accountings.AccountingUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.accounting.AccountResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthYearFormat;
import com.shsoftvina.erpshsoftvina.model.response.accounting.PageAccountListResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.RemainBalanceEachMonth;
import com.shsoftvina.erpshsoftvina.model.response.accounting.TotalSpendAndRemain;
import com.shsoftvina.erpshsoftvina.service.AccountingService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CompletableFuture;

@Service
public class AccountingServiceImpl implements AccountingService {
    @Autowired
    private AccountingMapper accountingMapper;
    @Autowired
    private AccountingConverter accountingConverter;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ApplicationUtils applicationUtils;

    @Override
    public MonthHistoryList findAllMonthlyHistory() {
        List<MonthYearFormat> monthHistoryList = accountingMapper.findAllMonthlyHistory();
        return accountingConverter.convertListToObjectDTO(monthHistoryList);
    }

    @Override
    public PageAccountListResponse findAccountingByMonth(Integer page, Integer size, LocalDate startTime, LocalDate endTime) {
        int offset = (page - 1) * size;
        RowBounds rowBounds = new RowBounds(offset, size);
        LocalDateTime endDateWithTime = (endTime != null) ? endTime.atTime(23, 59, 59) : null;
        CompletableFuture<List<Accounting>> accountingFuture = CompletableFuture.supplyAsync(() -> accountingMapper.findAccountingByMonth(rowBounds, startTime, endDateWithTime));
        CompletableFuture<TotalSpendAndRemain> totalFuture = CompletableFuture.supplyAsync(() -> accountingMapper.getTotalSpending(startTime, endDateWithTime));
        CompletableFuture<PageAccountListResponse> resultFuture = accountingFuture
                .thenCombine(totalFuture, (accountingList, totals) -> {
                    List<AccountResponse> accountResponses = accountingConverter.convertToListResponse(accountingList);
                    if (totals == null) {
                        return new PageAccountListResponse();
                    }
                    long totalPage = (long) Math.ceil((double) totals.getTotalRecordCount() / size);
                    boolean hasNext = page < totalPage;
                    boolean hasPrevious = page > 1;
                    return new PageAccountListResponse(accountResponses, page, totalPage, size, hasNext, hasPrevious, totals);
                });
        return resultFuture.join();
    }

    @Override
    public int createAccounting(AccountingCreateRequest accountingCreateRequest) {
        CompletableFuture<User> currentUserFuture = CompletableFuture.supplyAsync(() -> userMapper.findById(accountingCreateRequest.getUserId()));
        CompletableFuture<Accounting> beforeCreateAccounting = CompletableFuture.supplyAsync(() -> accountingMapper.findBeforeCurrentAccounting(DateUtils.toLocalDateTime(accountingCreateRequest.getPayDate())));
        long latestRemain = beforeCreateAccounting.thenApply(result -> {
            long lastRemain = 0L;
            if (result != null) {
                lastRemain = result.getRemain();
            }
            return lastRemain;
        }).join();
        User currentUser = currentUserFuture.thenApply(result -> {
            if (result == null) throw new NotFoundException(MessageErrorUtils.notFound("User id"));
            return result;
        }).join();

        MultipartFile[] billFile = accountingCreateRequest.getBill();
        List<String> oldFile = new ArrayList<>();
        if (billFile != null) {
            applicationUtils.checkValidateFileAndImage(Accounting.class, billFile, oldFile);
        }
        String dir = AccountingConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(dir, billFile);
        CompletableFuture.allOf(currentUserFuture,beforeCreateAccounting).join();
        Accounting newAccounting = accountingConverter.convertToEntity(accountingCreateRequest, currentUser, latestRemain, listFileNameSaveFileSuccess);
        try {
            accountingMapper.createAccounting(newAccounting);
            List<Accounting> remainRecordInMonthList = accountingMapper.getRemainRecordInMonth(newAccounting, true);
            if (!(remainRecordInMonthList.size() == 1)) {
                for (Accounting accounting : remainRecordInMonthList) {
                    latestRemain += accounting.getExpense();
                    accounting.setRemain(latestRemain);
                }
                accountingMapper.updateRecordsBatch(remainRecordInMonthList);
            }
        } catch (Exception e) {
            FileUtils.deleteMultipleFilesToServer(dir, newAccounting.getBill());
            return 0;
        }
        return 1;
    }

    @Override
    public AccountResponse updateAccounting(AccountingUpdateRequest accountingUpdateRequest) {
        Accounting currentAccounting = accountingMapper.findAccountingById(accountingUpdateRequest.getId());
        if (currentAccounting == null) throw new NotFoundException(MessageErrorUtils.notFound("Account id"));
        User currentUser = userMapper.findById(accountingUpdateRequest.getUserId());
        if (currentUser == null) throw new NotFoundException(MessageErrorUtils.notFound("User id"));
        String dir = AccountingConstant.UPLOAD_FILE_DIR;
        String fileList = currentAccounting.getBill();
        if (fileList == null) {
            fileList = "";
        }
        List<String> files = Arrays.asList(fileList.split(","));
        List<String> oldFile = Arrays.asList(accountingUpdateRequest.getOldFile());
        List<String> removeFiles = new ArrayList<>();
        List<String> newFiles = new ArrayList<>();
        for (String file : files) {
            if (!oldFile.contains(file)) {
                removeFiles.add(file);
            } else {
                newFiles.add(file);
            }
        }

        MultipartFile[] billFile = accountingUpdateRequest.getBill();
        if (billFile != null) {
            applicationUtils.checkValidateFileAndImage(Accounting.class, billFile, oldFile);
        }

        List<String> newFilesUpdate = FileUtils.saveMultipleFilesToServer(dir, billFile);
        assert newFilesUpdate != null;
        newFiles.addAll(newFilesUpdate);
        Accounting updateAccounting = accountingConverter.convertToEntity(accountingUpdateRequest, currentUser, newFiles);
        if (DateUtils.formatDate(currentAccounting.getPayDate()).equals(accountingUpdateRequest.getPayDate())) {
            try {
                updateAccounting.setPayDate(currentAccounting.getPayDate());
                accountingMapper.updateAccounting(updateAccounting);
                if (!Objects.equals(currentAccounting.getExpense(), accountingUpdateRequest.getExpense())) {
                    Accounting beforeCurrentAccounting = accountingMapper.findBeforeCurrentAccounting(currentAccounting.getPayDate());
                    List<Accounting> remainRecordInMonthList = accountingMapper.getRemainRecordInMonth(currentAccounting, true);
                    Long beforeRemain = 0L;
                    if (beforeCurrentAccounting != null) {
                        beforeRemain = beforeCurrentAccounting.getRemain();
                    }
                    for (Accounting accounting : remainRecordInMonthList) {
                        beforeRemain += accounting.getExpense();
                        accounting.setRemain(beforeRemain);
                    }
                    accountingMapper.updateRecordsBatch(remainRecordInMonthList);
                }
                FileUtils.deleteMultipleFilesToServer(dir, String.join(",", removeFiles));
            } catch (Exception e) {
                FileUtils.deleteMultipleFilesToServer(dir, String.join(",", newFilesUpdate));
                return null;
            }
        } else {
            try {
                accountingMapper.updateAccounting(updateAccounting);
                updateRemainsInTwoMonth(updateAccounting);

                if (!DateUtils.formatYearMonth(currentAccounting.getPayDate()).equals(accountingUpdateRequest.getPayDate())) {
                    updateRemainsInTwoMonth(currentAccounting);
                }

                FileUtils.deleteMultipleFilesToServer(dir, String.join(",", removeFiles));
            } catch (Exception e) {
                FileUtils.deleteMultipleFilesToServer(dir, String.join(",", newFilesUpdate));
                return null;
            }
        }
        return findAccountingById(accountingUpdateRequest.getId());
    }

    private void updateRemainsInTwoMonth(Accounting currentAccounting) {
        List<Accounting> remainRecordInMonthList = accountingMapper.getRemainRecordInMonth(currentAccounting, false);
        Long beforeRemain = 0L;
        for (Accounting accounting : remainRecordInMonthList) {
            beforeRemain += accounting.getExpense();
            accounting.setRemain(beforeRemain);
        }
        accountingMapper.updateRecordsBatch(remainRecordInMonthList);
    }

    @Override
    public int deleteAccounting(String id) {
        try {
            Accounting deleteAccounting = accountingMapper.findAccountingById(id);
            if (deleteAccounting == null) throw new NotFoundException(MessageErrorUtils.notFound("Account id"));
            accountingMapper.deleteAccounting(id);
            Accounting beforeCurrentAccounting = accountingMapper.findBeforeCurrentAccounting(deleteAccounting.getPayDate());
            List<Accounting> remainRecordInMonthList = accountingMapper.getRemainRecordInMonth(deleteAccounting, true);
            Long beforeRemain = 0L;
            if (beforeCurrentAccounting != null) {
                beforeRemain = beforeCurrentAccounting.getRemain();
            }
            if (remainRecordInMonthList.isEmpty()) {
                return 1;
            } else {
                for (Accounting accounting : remainRecordInMonthList) {
                    beforeRemain += accounting.getExpense();
                    accounting.setRemain(beforeRemain);
                }
                accountingMapper.updateRecordsBatch(remainRecordInMonthList);
                return 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public AccountResponse findAccountingById(String id) {
        CompletableFuture<Accounting> accountingFuture = CompletableFuture.supplyAsync(() -> accountingMapper.findAccountingById(id));
        CompletableFuture<AccountResponse> processedFuture = accountingFuture.thenApply(result -> accountingConverter.convertToResponseDTO(result));
        return processedFuture.join();
    }

    @Override
    public List<RemainBalanceEachMonth> getRemainBalanceEachMonth() {
        return accountingMapper.getRemainBalanceEachMonth();
    }

}

