package com.hieDev.minierp.model.response.managementtime.day;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ColorResponse {
    private String id;
    private String category;
    private String color;
    private String[] values;
}