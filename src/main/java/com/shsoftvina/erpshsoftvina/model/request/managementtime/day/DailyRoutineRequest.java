package com.shsoftvina.erpshsoftvina.model.request.managementtime.day;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DailyRoutineRequest {
    private String title;
    private int target;
    private String rate;
}
