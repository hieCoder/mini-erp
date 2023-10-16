package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.WeeklyReport;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface WeeklyReportMapper {
    List<WeeklyReport> getAllWeeklyReport(@Param("searchTerm") String searchTerm,
                                          @Param("userRole") String userRole,
                                          @Param("userId") String userId,
                                          RowBounds rowBounds);

    long getTotalWeeklyReport(@Param("searchTerm") String searchTerm,
                              @Param("userRole") String userRole,
                              @Param("userId") String userId);

    WeeklyReport findById(@Param("id") String id);

    int createWeeklyReport(WeeklyReport weeklyReport);
}
