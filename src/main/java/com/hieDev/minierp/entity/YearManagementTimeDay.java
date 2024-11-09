package com.hieDev.minierp.entity;

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
    private String selfInspiration;
    private String color;
    private User user;
}