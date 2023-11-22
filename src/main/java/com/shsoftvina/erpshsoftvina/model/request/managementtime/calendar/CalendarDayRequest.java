package com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar;

import com.shsoftvina.erpshsoftvina.model.request.managementtime.CalendarContent;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CalendarDayRequest {
    private Date day;
    private CalendarContent content;
}
