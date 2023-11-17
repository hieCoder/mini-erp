package com.shsoftvina.erpshsoftvina.model.response.allowance;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AllowanceResponse {
    private String id;
    private String item;
    private Integer itemValue;
}