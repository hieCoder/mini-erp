package com.shsoftvina.erpshsoftvina.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class YearManagementTimeDay {
    private String id;
    private String code;
    private String target;
    private String category;
    private String grateful;
    private String happy;
    private String whoUBecome;
    private String personalGoal;
    private String commendable;
    private String keywords3;
    private String color;
    private User user;
}