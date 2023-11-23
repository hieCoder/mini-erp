package com.shsoftvina.erpshsoftvina.model.request.managementtime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WeeklyRequest {
    private Date startDay;
    private CalendarContent content;
}