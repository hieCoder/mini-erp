package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ContractMapper {
    int addContract(Contract contract);
    Contract findById(@Param("id") String id);
    int updateContract(Contract contract);
    int changeStatusContract(@Param("id") String id,@Param("status") String status);
    List<Contract> getContractByUser(@Param("userId") String userId);

    int deleteById(String id);
}