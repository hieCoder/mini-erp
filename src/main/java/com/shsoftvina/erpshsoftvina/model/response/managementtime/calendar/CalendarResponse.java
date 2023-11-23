package com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar;

import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.WeeklyManagementTimeDayResponse;
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
    private String[] monthlyContents;
    private List<WeeklyManagementTimeDayResponse> weeklys;
}
