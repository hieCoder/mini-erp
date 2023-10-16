package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthYearFormat;
import com.shsoftvina.erpshsoftvina.model.response.accounting.TotalSpendAndRemain;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface AccountingMapper {

    List<MonthYearFormat> findAllMonthlyHistory();

    List<Accounting> findAccountingByMonth(@Param("monthId") String monthId, RowBounds rowBounds,@Param("startDate") LocalDate startDate,@Param("endDate") LocalDateTime endDate);

    long getTotalRecordCountPerMonth(@Param("monthId") String monthId, @Param("startDate") LocalDate startDate,@Param("endDate") LocalDateTime endDate);

    TotalSpendAndRemain getTotalSpending(@Param("monthId") String monthId);

    Long getLatestRemain(@Param("monthId") String monthId);

    int createAccounting(Accounting accounting);

    Accounting findAccountingById(String id);

    int updateAccounting(Accounting accounting);

    Accounting findBeforeCurrentAccounting(Accounting accounting);

    List<Accounting> getRemainRecordInMonth(Accounting currentAccounting);

    void updateRecordsBatch(List<Accounting> remainRecordInMonthList);

    void deleteAccounting(String id);
}

