package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ContractMapper {
    int addContract(Contract contract);
    int deleteById(String id);
    int changeStatusContract(@Param("id") String id,@Param("status") String status);
    Contract findById(String id);
    List<Contract> getHistoryContract(String id);
//    int updateContract(Contract contract);
}