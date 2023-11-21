package com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CalendarWeeklyRequest {
    private Date startDay;
    private CalendarContent content;
}
