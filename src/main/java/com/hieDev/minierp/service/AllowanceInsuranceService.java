package com.hieDev.minierp.service;

import com.hieDev.minierp.entity.AllowanceInsurance;
import com.hieDev.minierp.entity.Contract;

import java.util.List;

public interface AllowanceInsuranceService {
    List<AllowanceInsurance> insertAllowanceInsurances(Contract contract, String json);
    int deleteAllowanceInsurances(String id);
    List<AllowanceInsurance> updateAllowanceInsurances(Contract contract, String json);
}