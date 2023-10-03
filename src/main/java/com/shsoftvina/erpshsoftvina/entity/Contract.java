package com.shsoftvina.erpshsoftvina.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Time;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Contract {

    private String id;
    private Date workingDay;
    private String basicSalary;
    private String allowance;
    private String contract;
    private Date createdDate;
    private User user;
    private Insurance insurance;
}