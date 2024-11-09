package com.hieDev.minierp.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hieDev.minierp.exception.NotFoundException;
import com.hieDev.minierp.entity.AllowanceInsurance;
import com.hieDev.minierp.entity.Contract;
import com.hieDev.minierp.enums.allowance_insurance.AllowanceInsuranceType;
import com.hieDev.minierp.mapper.AllowanceInsuranceMapper;
import com.hieDev.minierp.mapper.ContractMapper;
import com.hieDev.minierp.model.request.allowance_insurance.AllowanceInsuranceRequest;
import com.hieDev.minierp.service.AllowanceInsuranceService;
import com.hieDev.minierp.utils.EnumUtils;
import com.hieDev.minierp.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class AllowanceInsuranceServiceImpl implements AllowanceInsuranceService {

    @Autowired
    private AllowanceInsuranceMapper allowanceInsuranceMapper;

    @Autowired
    private ContractMapper contractMapper;

    @Override
    public List<AllowanceInsurance> insertAllowanceInsurances(Contract contract, String json) {
        List<AllowanceInsurance> list = new ArrayList<>();

        if (contract != null) {
            ObjectMapper objectMapper = new ObjectMapper();
            List<AllowanceInsuranceRequest> listReq = null;
            try {
                listReq = objectMapper.readValue(json, new TypeReference<List<AllowanceInsuranceRequest>>() {
                });
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
            for (AllowanceInsuranceRequest ai : listReq) {

                AllowanceInsuranceType allowanceInsuranceType = EnumUtils.getEnumFromValue(AllowanceInsuranceType.class, ai.getType());
                if (allowanceInsuranceType == null) throw new NotFoundException(MessageErrorUtils.notFound("Type"));

                list.add(new AllowanceInsurance(null, ai.getItem(), ai.getItemValue(), contract, allowanceInsuranceType));
            }

            try {
                allowanceInsuranceMapper.insertAllowanceInsurances(list);
                return list;
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return null;
    }

    @Override
    public int deleteAllowanceInsurances(String id) {
        return allowanceInsuranceMapper.deleteAllowanceInsurances(id);
    }

    @Override
    public List<AllowanceInsurance> updateAllowanceInsurances(Contract contract, String json) {
        List<AllowanceInsurance> list = new ArrayList<>();

        if(contract != null){
            ObjectMapper objectMapper = new ObjectMapper();
            List<AllowanceInsuranceRequest> listReq = null;
            try {
                listReq = objectMapper.readValue(json, new TypeReference<List<AllowanceInsuranceRequest>>() {
                });
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
            int deleteSuccess = allowanceInsuranceMapper.deleteAllowanceInsurances(contract.getId());
            if(deleteSuccess> 0){
                for (AllowanceInsuranceRequest ai : listReq) {
                    AllowanceInsuranceType allowanceInsuranceType = EnumUtils.getEnumFromValue(AllowanceInsuranceType.class, ai.getType());
                    if(allowanceInsuranceType == null) throw new NotFoundException(MessageErrorUtils.notFound("Type"));

                    list.add(new AllowanceInsurance(null, ai.getItem(), ai.getItemValue(), contract, allowanceInsuranceType));
                }
                try{
                    allowanceInsuranceMapper.insertAllowanceInsurances(list);
                    return list;
                } catch (Exception e){
                    System.out.println(e);
                }
            }
        }
        return null;
    }
}