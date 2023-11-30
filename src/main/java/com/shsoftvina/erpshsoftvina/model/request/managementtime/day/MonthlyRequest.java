package com.shsoftvina.erpshsoftvina.model.request.managementtime.day;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MonthlyRequest {
    private String month;
    private String[] content;
    private DailyRoutineRequest[] dailyRoutine;
}
