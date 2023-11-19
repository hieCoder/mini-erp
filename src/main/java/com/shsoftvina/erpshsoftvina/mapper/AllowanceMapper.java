package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Allowance;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AllowanceMapper {
    int insertAllowances(List<Allowance> list);
}