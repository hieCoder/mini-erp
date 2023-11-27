package com.shsoftvina.erpshsoftvina.model.response.managementtime.day;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MonthResponse {
    private String month;
    private String[] monthlyContents;
    private DailyRoutineResponse[] dailyRoutine;
}