package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface WeeklyManagementTimeDayMapper {
    WeeklyManagementTimeDay findByCode(String userId, String code);
    int createWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);
    int updateWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);

    List<WeeklyManagementTimeDay> findByListCode(String userId, String[] codes);
}
