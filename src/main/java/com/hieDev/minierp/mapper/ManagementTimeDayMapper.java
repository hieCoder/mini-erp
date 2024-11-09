package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.ManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

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
    List<ManagementTimeDay> findSpendingByMonthCode(String userId, String monthCode);
    List<ManagementTimeDay> getPerformance(String weeklyCode);
}