package com.hieDev.minierp.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WeeklyManagementTimeDay {
    private String id;
    private String code;
    private String content;
    private String gratitudeDiary;
    private String compliment;
    private String reflectionAndImprovement;
    private User user;
}
