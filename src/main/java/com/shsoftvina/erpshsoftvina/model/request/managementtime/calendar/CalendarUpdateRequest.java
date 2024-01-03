package com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.QuoteDto;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.WeeklyRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.YearRequest;
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
