package com.shsoftvina.erpshsoftvina.model.response.managementtime.day;

import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarWeeklyContent;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WeeklyManagementTimeDayResponse {
    private String weeklyId;
    private String startDate;
    private CalendarWeeklyContent weeklyContents;
    private String[] monthlyContents;
    private List<DayResponse> listDayOfWeek;
}
