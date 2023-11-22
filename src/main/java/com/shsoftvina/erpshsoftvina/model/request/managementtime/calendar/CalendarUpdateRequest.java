package com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.MonthlyRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.WeeklyRequest;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CalendarUpdateRequest {
    private String userId;
    private List<CalendarDayRequest> days;
    private List<WeeklyRequest> weeklys;
    private MonthlyRequest monthly;
}
