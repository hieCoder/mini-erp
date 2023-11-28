package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface WeeklyManagementTimeDayMapper {
    List<WeeklyManagementTimeDay> findByListCode(String userId, List<String> codes);
    int createListWeekly(List<WeeklyManagementTimeDay> weeklys);
    int editListWeekly(List<WeeklyManagementTimeDay> weeklys);
    int updateContentNull(String userId, List<String> codes);
    int updateContentAllWeeklyNull(String userId, List<String> codes);
    WeeklyManagementTimeDay findByCode(String userId, String code);
    int createWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);
    int updateWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);
}
