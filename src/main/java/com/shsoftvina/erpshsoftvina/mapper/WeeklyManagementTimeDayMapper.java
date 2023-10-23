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

    WeeklyManagementTimeDay findByStartDateAndEndDateOfUser(@Param("userId") String userId,
                                                            @Param("firstDayOfWeek") LocalDate firstDayOfWeek,
                                                            @Param("lastDayOfWeek") LocalDate lastDayOfWeek);
    int createWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);

    WeeklyManagementTimeDay findByCodeOfUser(@Param("userId") String userId,
                                             @Param("code") String code);

    int updateWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);

    WeeklyManagementTimeDay findById(@Param("id") String id);
}
