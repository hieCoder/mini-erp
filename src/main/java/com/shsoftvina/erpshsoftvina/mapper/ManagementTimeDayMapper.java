package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.entity.Timesheets;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Mapper
public interface ManagementTimeDayMapper {

//    int createDayInfo(ManagementTimeDay day);
//    int updateDayInfo(ManagementTimeDay day);
//    ManagementTimeDay findById(String id);
    ManagementTimeDay findByDay(String userId, Date day);
    int createCalendarDay(ManagementTimeDay day);
    int updateCalendarDay(ManagementTimeDay day);
    List<ManagementTimeDay> findDays(String userId, String startDate, String endDate);
    List<ManagementTimeDay> findByCode(String userId, String weeklyCode);
    int insertDaysBatch(List<ManagementTimeDay> list);
}