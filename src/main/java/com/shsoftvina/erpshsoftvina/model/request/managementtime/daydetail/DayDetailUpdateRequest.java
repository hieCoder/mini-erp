package com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DayDetailUpdateRequest {
    private String id;

    private String code;
    private String[] data;
}
