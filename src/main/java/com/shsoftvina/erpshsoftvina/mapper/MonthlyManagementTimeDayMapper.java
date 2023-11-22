package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.MonthlyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MonthlyManagementTimeDayMapper {
    MonthlyManagementTimeDay findByCode(String userId, String code);
    int createMonthlyManagementTimeDay(MonthlyManagementTimeDay monthlyManagementTimeDay);
    int updateMonthlyManagementTimeDay(MonthlyManagementTimeDay monthlyManagementTimeDay);
}
