package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.entity.Allowance;
import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.mapper.AllowanceMapper;
import com.shsoftvina.erpshsoftvina.mapper.ContractMapper;
import com.shsoftvina.erpshsoftvina.service.AllowanceService;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class AllowanceServiceImpl implements AllowanceService {

    @Autowired
    private AllowanceMapper allowanceMapper;

    @Autowired
    private ContractMapper contractMapper;

    @Override
    public List<Allowance> insertAllowances(String contractId, String json) {
        List<Allowance> list = new ArrayList<>();

        Contract contract = contractMapper.findById(contractId);
        if(contract != null){
            Map<String, String> map = JsonUtils.jsonToObject(json, Map.class);
            for (Map.Entry<String, String> entry : map.entrySet()) {
                list.add(new Allowance(null, entry.getKey(), Integer.parseInt(entry.getValue()), contract));
            }

            try{
                allowanceMapper.insertAllowances(list);
                return list;
            } catch (Exception e){}
        }
        return null;
    }

    @Override
    public int deleteAllowances(String id) {
        return allowanceMapper.deleteAllowances(id);
    }
}