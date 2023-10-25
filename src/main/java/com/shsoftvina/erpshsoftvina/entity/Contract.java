package com.shsoftvina.erpshsoftvina.entity;

import com.shsoftvina.erpshsoftvina.enums.contract.InsuranceTypeEnum;
import com.shsoftvina.erpshsoftvina.enums.contract.StatusContractEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Contract {

    private String id;
    private String basicSalary;
    private String allowance;
    private String contract;
    private Date createdDate;
    private User user;
    private InsuranceTypeEnum insuranceType;
    private String insuranceMoney;
    private StatusContractEnum status;
    private Contract parentContract;
    private List<Contract> historyContract;
}