package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.converter.accounting.AccountingConverter;
import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.User;
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
import com.shsoftvina.erpshsoftvina.utils.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

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
            endDateWithTime = endTime.atTime(23,59,59);
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
        LocalDateTime newDate = LocalDateTime.now();
        String formattedMonthYear = DateUtils.formatMonthYear(newDate);
        Long latestRemain = accountingMapper.getLatestRemain(formattedMonthYear);
        MultipartFile billFile = accountingCreateRequest.getBill();
        String uploadDir = UserConstant.UPLOAD_FILE_DIR;
        boolean isSaveBill = true;
        String billDBValue = null;
        if(billFile != null){
            billDBValue = FileUtils.formatNameImage(billFile);
            isSaveBill = FileUtils.saveImageToServer(request, uploadDir, billFile, billDBValue);
        }
        if (isSaveBill) {
            User currentUser = userMapper.findUserDetail(accountingCreateRequest.getUserId());
            Accounting accounting = accountingConverter.convertToEntity(accountingCreateRequest,currentUser,latestRemain, newDate);
            accounting.setBill(billDBValue);
            int rs = accountingMapper.createAccounting(accounting);
            if(rs == 0) {
                FileUtils.deleteImageFromServer(request, uploadDir, billDBValue);
                return 0;
            }
            return 1;
        } else{
            return 0;
        }
    }

    @Override
    public int updateAccounting(AccountingUpdateRequest accountingUpdateRequest) {
        MultipartFile billFile = accountingUpdateRequest.getBill();
        String uploadDir = UserConstant.UPLOAD_FILE_DIR;
        boolean isSaveBill = true;
        String billDBValue = null;
        if (billFile != null) {
            billDBValue = FileUtils.formatNameImage(billFile);
            isSaveBill = FileUtils.saveImageToServer(request,uploadDir,billFile,billDBValue);
        }

        if(isSaveBill) {
            User currentUser = userMapper.findUserDetail(accountingUpdateRequest.getId());
            Accounting accounting = accountingConverter.convertToEntity(accountingUpdateRequest,currentUser);
            Accounting currentAccountInDB = accountingMapper.findAccountingById(accountingUpdateRequest.getId());
            accounting.setBill(billDBValue);
            int rs = accountingMapper.updateAccounting(accounting);
            if (rs == 0) {
                FileUtils.deleteImageFromServer(request,uploadDir,billDBValue);
                return 0;
            }

            if(!StringUtils.isEmpty(currentAccountInDB.getBill())) {
                FileUtils.deleteImageFromServer(request,uploadDir,currentAccountInDB.getBill());
            }
            return 1;
        }
        else {
            return 0;
        }
    }
}

