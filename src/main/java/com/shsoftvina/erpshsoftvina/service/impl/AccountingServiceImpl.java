package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.AccountingConverter;
import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.mapper.AccountingMapper;
import com.shsoftvina.erpshsoftvina.model.response.accountings.AccountResponse;
import com.shsoftvina.erpshsoftvina.model.response.accountings.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accountings.PageAccountListResponse;
import com.shsoftvina.erpshsoftvina.service.AccountingService;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccountingServiceImpl implements AccountingService {
    @Autowired
    private AccountingMapper accountingMapper;
    @Autowired
    private AccountingConverter accountingConverter;
    @Override
    public MonthHistoryList findAllMonthlyHistory() {
        List<String> monthHistoryList =  accountingMapper.findAllMonthlyHistory();
        return accountingConverter.convertListToObjectDTO(monthHistoryList);
    }

    @Override
    public PageAccountListResponse findAccountingByMonth(Integer monthId, Integer page, Integer size) {
        int offset = page * size;
        RowBounds rowBounds = new RowBounds(offset,size);
        List<Accounting> accountingList = accountingMapper.findAccountingByMonth(monthId,rowBounds);
        long totalRecordCount = accountingMapper.getTotalRecordCountPerMonth(monthId);
        long totalPage = (totalRecordCount + size -1) / size;
        boolean hasNext = page < (totalPage -1);
        boolean hasPrevious = page > 0;
        List<AccountResponse> accountResponses = accountingConverter.convertToListResponse(accountingList);
        return new PageAccountListResponse(accountResponses,page,totalPage,hasNext,hasPrevious);
    }
}
