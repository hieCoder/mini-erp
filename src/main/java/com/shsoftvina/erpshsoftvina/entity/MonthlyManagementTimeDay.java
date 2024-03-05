package com.shsoftvina.erpshsoftvina.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MonthlyManagementTimeDay {
    private String id;
    private String code;
    private String content;
    private User user;
    private String dailyRoutine;
    private Float spendingGoals;
    private String targetCategory;
    private String gratitudeDiary;
    private String compliment;
    private String reflectionAndImprovement;
    private String timeUsedCategory;
}