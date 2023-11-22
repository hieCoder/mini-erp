package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.entity.AllowanceInsurance;

import java.util.List;

public interface AllowanceInsuranceService {
    List<AllowanceInsurance> insertAllowanceInsurances(String contractId, String json);
    int deleteAllowanceInsurances(String id);
    List<AllowanceInsurance> updateAllowanceInsurances(String contractId, String json);
}