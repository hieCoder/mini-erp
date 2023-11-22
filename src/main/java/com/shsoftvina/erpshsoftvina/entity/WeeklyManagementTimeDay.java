package com.shsoftvina.erpshsoftvina.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WeeklyManagementTimeDay {
    private String id;
    private String code;
    private String content;
    private User user;
}
