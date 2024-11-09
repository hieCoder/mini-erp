package com.hieDev.minierp.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ColorManagementTimeDay {
    private String id;
    private String category;
    private String color;
    private String values;
    private YearManagementTimeDay year;
}
