package com.shsoftvina.erpshsoftvina.model.request.managementtime.calendar;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CalendarContent {
    private String theSingleMostImportantThing;
    private String lecture;
    private String dailyEvaluation;
    private String work;
    private String reading;
}
