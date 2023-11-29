package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.entity.Timesheets;
import com.shsoftvina.erpshsoftvina.entity.WeeklyManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Mapper
public interface ManagementTimeDayMapper {
    List<ManagementTimeDay> findByListDay(String userId, List<String> days);
    int createListCalendarDay(List<ManagementTimeDay> days);
    int editListCalendarDay(List<ManagementTimeDay> days);
    int updateOneThingCalendarAllDayNull(String userId, List<String> days);
    List<ManagementTimeDay> findAllDailyRoutineOfMonth(String userId, String monthlyCode);
    List<ManagementTimeDay> findByCode(String userId, String weeklyCode);
    int createListDayDetail(List<ManagementTimeDay> days);
    int editListDayDetail(List<ManagementTimeDay> days);
    List<ManagementTimeDay> findByListCode(String userId, List<String> codes);
}