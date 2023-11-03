package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface WeeklyReportMapper {
    List<WeeklyReport> getAllWeeklyReportByUser(@Param("userId") String userId, RowBounds rowBounds);
    long getTotalWeeklyReportByUser(@Param("userId") String userId,
                              RowBounds rowBounds);
    WeeklyReport findById(@Param("id") String id);
    int createWeeklyReport(WeeklyReport weeklyReport);
    int updateWeeklyReport(WeeklyReport weeklyReport);
}
