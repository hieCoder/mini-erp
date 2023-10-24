package com.shsoftvina.erpshsoftvina.model.response.managementtime.day;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WeeklyManagementTimeDayResponse {
    private String weeklyId;
    private String startDate;
    private String[] weeklyContents;
    private List<DayResponse> listDayOfWeek;
}
