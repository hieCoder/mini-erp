package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.WeeklyReport;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface WeeklyReportMapper {
    List<WeeklyReport> getAllWeeklyReportByUser( String userId, RowBounds rowBounds);
    long getTotalWeeklyReportByUser( String userId);
    WeeklyReport findById( String id);
    int createWeeklyReport(WeeklyReport weeklyReport);
    int updateWeeklyReport(WeeklyReport weeklyReport);
    int deleteWeeklyReport(String id);
}
