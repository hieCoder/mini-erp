package com.hieDev.minierp.model.request.managementtime.calendar;

import com.hieDev.minierp.model.dto.management_time.QuoteDto;
import com.hieDev.minierp.model.request.managementtime.WeeklyRequest;
import com.hieDev.minierp.model.request.managementtime.YearRequest;
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
    private CalendarMonthlyRequest monthly;
    private QuoteDto quotes;
    private YearRequest year;
}
