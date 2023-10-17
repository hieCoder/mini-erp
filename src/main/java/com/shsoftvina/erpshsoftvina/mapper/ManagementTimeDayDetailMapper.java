package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDayDetail;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ManagementTimeDayDetailMapper {
    int createTimeDayDetail(ManagementTimeDayDetail managementTimeDayDetail);
    int updateTimeDayDetail(ManagementTimeDayDetail managementTimeDayDetail);
}
