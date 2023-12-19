package com.shsoftvina.erpshsoftvina.model.request.managementtime.day;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CostsRequest {
    private String item;
    private String amt;
    private String type;
}
