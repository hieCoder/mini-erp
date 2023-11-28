package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.MonthlyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MonthlyManagementTimeDayMapper {
    List<MonthlyManagementTimeDay> findByListCode(String userId, List<String> codes);



    MonthlyManagementTimeDay findByCode(String userId, String code);
    int createMonthlyManagementTimeDay(MonthlyManagementTimeDay monthlyManagementTimeDay);
    int updateMonthlyManagementTimeDay(MonthlyManagementTimeDay monthlyManagementTimeDay);
}
