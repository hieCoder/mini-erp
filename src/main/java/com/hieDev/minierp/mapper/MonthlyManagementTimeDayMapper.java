package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.MonthlyManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MonthlyManagementTimeDayMapper {
    List<MonthlyManagementTimeDay> findByListCode(String userId, List<String> codes);
    MonthlyManagementTimeDay findByCode(String userId, String code);
    List<MonthlyManagementTimeDay> findByYear(String userId, String year);
    int createMonthlyManagementTimeDay(MonthlyManagementTimeDay monthlyManagementTimeDay);
    int updateMonthlyManagementTimeDay(MonthlyManagementTimeDay monthlyManagementTimeDay);
    int createSpendingMonthlyManagementTimeDay(MonthlyManagementTimeDay monthlyManagementTimeDay);
    int updateSpendingMonthlyManagementTimeDay(MonthlyManagementTimeDay monthlyManagementTimeDay);
}
