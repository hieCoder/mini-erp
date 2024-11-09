package com.hieDev.minierp.model.response.managementtime.calendar;

import com.hieDev.minierp.model.dto.management_time.MonthlyContentDto;
import com.hieDev.minierp.model.response.managementtime.WeeklyManagementTimeDayResponse;
import com.hieDev.minierp.model.response.managementtime.day.YearResponse;
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