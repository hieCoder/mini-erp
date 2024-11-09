package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.YearManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface YearManagementTimeDayMapper {
    int createYearManagementTimeDay(YearManagementTimeDay yearManagementTimeDay);
    YearManagementTimeDay findByCode(String userId, String code);
    int updateYearManagementTimeDay(YearManagementTimeDay yearManagementTimeDay);
}
