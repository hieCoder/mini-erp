package com.hieDev.minierp.model.request.managementtime.calendar;

import com.hieDev.minierp.model.dto.management_time.MonthlyContentDto;
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
}
