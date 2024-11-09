package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.WeeklyManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface WeeklyManagementTimeDayMapper {
    List<WeeklyManagementTimeDay> findByListCode(String userId, List<String> codes);
    int createListWeekly(List<WeeklyManagementTimeDay> weeklys);
    int editListWeekly(List<WeeklyManagementTimeDay> weeklys);
    int createListWeeklyReview(List<WeeklyManagementTimeDay> weeklys);
    int editListWeeklyReview(List<WeeklyManagementTimeDay> weeklys);
    int updateContentAllWeeklyNull(String userId, List<String> codes);
    WeeklyManagementTimeDay findByCode(String userId, String code);
    int createWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);
    int updateWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);
}
