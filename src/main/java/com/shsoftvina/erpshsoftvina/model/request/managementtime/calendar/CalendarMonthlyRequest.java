package com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.MonthlyContentDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CalendarMonthlyRequest {
    private String month;
    private MonthlyContentDto[] content;
    private String[] color;
}
