package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Task;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Mapper
public interface ScheduleMapper {
    List<Task> getScheduleDetail(String userId, Date startDate, Date endDate);
    List<Task> getScheduleDetailByMonth(String userId, LocalDate previousMonth,LocalDate nextMonth);
}
