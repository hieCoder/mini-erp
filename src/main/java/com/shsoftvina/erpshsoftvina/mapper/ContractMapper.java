package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ContractMapper {
    int addContract(Contract contract);
    Contract findById(String id);
    int updateContract(Contract contract);
    int changeStatusContract(String id,String status);
    List<Contract> getContractByUser(String userId);
}