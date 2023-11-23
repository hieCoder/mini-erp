package com.shsoftvina.erpshsoftvina.model.request.managementtime;

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
}
