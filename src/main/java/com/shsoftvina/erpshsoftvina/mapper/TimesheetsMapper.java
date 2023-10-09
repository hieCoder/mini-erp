package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Timesheets;
import com.shsoftvina.erpshsoftvina.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface TimesheetsMapper {

    List<Timesheets> findAll(@Param("start") int start,
                             @Param("pageSize") int pageSize
    );
    List<Map<String, ?>> totalWorkingDateByYear(@Param("userID") String userID);
    List<Map<String, ?>> totalWorkingDateByMonth(@Param("userID") String userID, @Param("year") String year);
}