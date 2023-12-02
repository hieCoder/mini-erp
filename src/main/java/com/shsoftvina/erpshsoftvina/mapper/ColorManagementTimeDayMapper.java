package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.ColorManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ColorManagementTimeDayMapper {
    int deleteAllByUserId(String userId);
    int createColors(List<ColorManagementTimeDay> colors);
    List<ColorManagementTimeDay> findAllByUserId(String userId);
}
