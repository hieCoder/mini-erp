package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.AllowanceInsurance;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AllowanceInsuranceMapper {
    int insertAllowanceInsurances(List<AllowanceInsurance> list);
    int deleteAllowanceInsurances(String id);
}