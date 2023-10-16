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
    List<ManagementTimeDay> findAllByMonthYear(@Param("userId") String userId,
                                               @Param("month") String month,
                                               @Param("year") String year);
}