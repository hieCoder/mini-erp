package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.Timesheets;
import org.apache.ibatis.annotations.Mapper;

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