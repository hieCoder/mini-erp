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
    ManagementTimeDay findByDay(String userId, Date day);
    int createCalendarDay(ManagementTimeDay day);
    int updateCalendarDay(ManagementTimeDay day);
    List<ManagementTimeDay> findByCode(String userId, String weeklyCode);
    int insertDay(ManagementTimeDay day);
    int editDay(ManagementTimeDay managementTimeDay);
    List<ManagementTimeDay> findAllDailyRoutineOfMonth(String userId, String monthlyCode);

    int createListCalendarDay(List<ManagementTimeDay> days);
}