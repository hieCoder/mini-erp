package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.AllowanceInsurance;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AllowanceInsuranceMapper {
    int insertAllowanceInsurances(List<AllowanceInsurance> list);
    int deleteAllowanceInsurances(String id);
}