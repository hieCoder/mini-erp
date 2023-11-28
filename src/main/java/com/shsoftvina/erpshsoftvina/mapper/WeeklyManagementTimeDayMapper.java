package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface WeeklyManagementTimeDayMapper {
    WeeklyManagementTimeDay findByCode(String userId, String code);
    int createWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);
    int updateWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);

    List<WeeklyManagementTimeDay> findByListCode(String userId, List<String> codes);
    int createListWeekly(List<WeeklyManagementTimeDay> weeklys);
    void updateContentNull(String userId, List<String> codes);
}
