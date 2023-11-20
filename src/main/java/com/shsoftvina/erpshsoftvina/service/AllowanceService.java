package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.entity.Allowance;

import java.util.List;

public interface AllowanceService {
    List<Allowance> insertAllowances(String contractId, String json);
    int deleteAllowances(String id);
    List<Allowance> updateAllowances(String contractId, String json);
}