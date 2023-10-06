package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface WeeklyReportMapper {
    List<WeeklyReport> getAllWeeklyReport(@Param("page") int page,
                                          @Param("pageSize") int pageSize,
                                          @Param("searchTerm") String searchTerm);
    WeeklyReport findById(@Param("id") String id);
    int createWeeklyReport(WeeklyReport weeklyReport);
}
