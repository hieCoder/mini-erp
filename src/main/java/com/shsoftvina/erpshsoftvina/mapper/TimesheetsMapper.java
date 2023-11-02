package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Timesheets;
import com.shsoftvina.erpshsoftvina.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface TimesheetsMapper {

    List<Timesheets> findAllByUserAndMonthYear(@Param("userId") String userId,
                             @Param("year") int year, @Param("month") int month);
    List<Map<String, ?>> totalWorkingDateByYear(@Param("userID") String userID);
    List<Map<String, ?>> totalWorkingDateByMonth(@Param("userID") String userID, @Param("year") String year);
    int insertTimesheetsBatch(List<Timesheets> list);
}