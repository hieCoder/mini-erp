package com.shsoftvina.erpshsoftvina.model.dto.management_time;

import com.shsoftvina.erpshsoftvina.enums.managementtime_daydetail.TimeRangeEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PlanDto {
    private String content;
    private boolean performance;
}