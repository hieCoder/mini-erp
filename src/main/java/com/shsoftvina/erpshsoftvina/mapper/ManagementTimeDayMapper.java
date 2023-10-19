package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.entity.Timesheets;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ManagementTimeDayMapper {

    int createDayInfo(ManagementTimeDay day);
    int updateDayInfo(ManagementTimeDay day);
    ManagementTimeDay findById(String id);
    ManagementTimeDay findByDay(@Param("userId") String userId, @Param("day") String day);
    List<ManagementTimeDay> findAllByMonthYear(@Param("userId") String userId,
                                               @Param("startDate") String startDate,
                                               @Param("endDate") String endDate);
}