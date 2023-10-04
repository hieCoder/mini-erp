package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.ManagementTime;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TodoManagementMapper {
    List<ManagementTime> findTotalElementPerMonth();
}
