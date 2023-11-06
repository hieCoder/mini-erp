package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Task;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Mapper
public interface ScheduleMapper {
    List<Task> getScheduleDetail(@Param("userId") String userId, @Param("startDate") Date startDate, @Param("endDate") Date endDate);
    List<Task> getScheduleDetailByMonth(@Param("userId") String userId, @Param("prevMonth") LocalDate previousMonth, @Param("nextMonth") LocalDate nextMonth);
}
