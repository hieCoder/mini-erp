package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.model.response.accountings.TotalSpendAndRemain;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface AccountingMapper {

    List<String> findAllMonthlyHistory();

    List<Accounting> findAccountingByMonth(@Param("monthId") String monthId, RowBounds rowBounds,@Param("startDate") LocalDate startDate,@Param("endDate") LocalDateTime endDate);

    long getTotalRecordCountPerMonth(String monthId);

    TotalSpendAndRemain getTotalSpending(@Param("monthId") String monthId);

    Long getLatestRemain(@Param("monthId") String monthId);

    int createAccounting(Accounting accounting);

    Accounting findAccountingById(String id);

    int updateAccounting(Accounting accounting);
}

