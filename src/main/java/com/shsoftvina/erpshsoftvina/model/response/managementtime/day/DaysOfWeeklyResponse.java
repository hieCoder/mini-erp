package com.shsoftvina.erpshsoftvina.model.response.managementtime.day;

import com.shsoftvina.erpshsoftvina.model.response.managementtime.WeeklyManagementTimeDayResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarDayResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DaysOfWeeklyResponse {
    private List<MonthResponse> monthlys;
    private WeeklyManagementTimeDayResponse weeklys;
    private List<DayResponse> days;
    private List<ColorResponse> colors;
    private QuoteResponse quotes;
    private YearResponse year;
    private List<CalendarDayResponse> getPerformace;
}