package com.shsoftvina.erpshsoftvina.model.request.managementtime.day;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.WeeklyRequest;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DaysUpdateRequest {
    private String userId;
    private MonthlyRequest monthly;
    private WeeklyRequest weekly;
    private DayRequest[] days;
    private ColorRequest[] colors;
    private String[] quotes;
    private YearRequest year;
}