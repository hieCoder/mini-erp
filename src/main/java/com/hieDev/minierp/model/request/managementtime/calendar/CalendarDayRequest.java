package com.hieDev.minierp.model.request.managementtime.calendar;

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
    private String[] content;
}
