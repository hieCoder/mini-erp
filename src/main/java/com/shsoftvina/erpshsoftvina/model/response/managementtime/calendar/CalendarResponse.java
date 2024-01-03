package com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.MonthlyContentDto;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.WeeklyManagementTimeDayResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.YearResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CalendarResponse {
    private MonthlyContentDto[] monthlyContents;
    private String[] color;
    private List<CalendarDayResponse> days;
    private List<WeeklyManagementTimeDayResponse> weeklys;
    private YearResponse year;
}