package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.entity.AllowanceInsurance;
import com.shsoftvina.erpshsoftvina.entity.Contract;

import java.util.List;

public interface AllowanceInsuranceService {
    List<AllowanceInsurance> insertAllowanceInsurances(Contract contract, String json);
    int deleteAllowanceInsurances(String id);
    List<AllowanceInsurance> updateAllowanceInsurances(Contract contract, String json);
}