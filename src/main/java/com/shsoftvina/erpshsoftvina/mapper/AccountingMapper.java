package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthYearFormat;
import com.shsoftvina.erpshsoftvina.model.response.accounting.RemainBalanceEachMonth;
import com.shsoftvina.erpshsoftvina.model.response.accounting.TotalSpendAndRemain;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface AccountingMapper {

    List<MonthYearFormat> findAllMonthlyHistory();

    List<Accounting> findAccountingByMonth(RowBounds rowBounds,LocalDate startDate,LocalDateTime endDate);

    TotalSpendAndRemain getTotalSpending(LocalDate startDate,LocalDateTime endDate);

    int createAccounting(Accounting accounting);

    Accounting findAccountingById(String id);

    int updateAccounting(Accounting accounting);

    Accounting findBeforeCurrentAccounting(LocalDateTime payDate);

    List<Accounting> getRemainRecordInMonth(Accounting currentAccounting, Boolean inMonth);

    void updateRecordsBatch(List<Accounting> remainRecordInMonthList);

    void deleteAccounting(String id);

    List<RemainBalanceEachMonth> getRemainBalanceEachMonth();
}

