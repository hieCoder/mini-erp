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

    WeeklyManagementTimeDay findByStartDateAndEndDateOfUser( String userId,
                                                             LocalDate firstDayOfWeek,
                                                            LocalDate lastDayOfWeek);
    int createWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);

    WeeklyManagementTimeDay findByCodeOfUser( String userId,
                                              String code);

    int updateWeeklyManagementTimeDay(WeeklyManagementTimeDay weeklyManagementTimeDay);

    WeeklyManagementTimeDay findById(String id);
}
