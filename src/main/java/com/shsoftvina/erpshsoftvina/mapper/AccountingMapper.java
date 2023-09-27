package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Accounting;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface AccountingMapper {

    List<String> findAllMonthlyHistory();

    List<Accounting> findAccountingByMonth(@Param("monthId") Integer monthId, RowBounds rowBounds);

    long getTotalRecordCountPerMonth(Integer id);
}
