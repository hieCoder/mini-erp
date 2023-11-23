package com.shsoftvina.erpshsoftvina.model.response.managementtime.day;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DaysOfWeeklyResponse {
    private MonthResponse monthlys;
    private WeeklyManagementTimeDayResponse weeklys;
}