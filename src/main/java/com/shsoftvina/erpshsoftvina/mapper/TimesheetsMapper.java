package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Timesheets;
import com.shsoftvina.erpshsoftvina.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface TimesheetsMapper {

    List<Timesheets> findAllByUserAndMonthYear( String userId,
                             int year,  int month);
    List<Map<String, ?>> totalWorkingDateByYear(String userID);
    List<Map<String, ?>> totalWorkingDateByMonth(String userID,  String year);
    int insertTimesheetsBatch(List<Timesheets> list);
}