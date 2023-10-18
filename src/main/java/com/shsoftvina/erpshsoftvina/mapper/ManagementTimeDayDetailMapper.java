package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDayDetail;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ManagementTimeDayDetailMapper {
    int createTimeDayDetail(ManagementTimeDayDetail managementTimeDayDetail);
    int updateTimeDayDetail(ManagementTimeDayDetail managementTimeDayDetail);
    ManagementTimeDayDetail findById(@Param("id") String id);
}
