package com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.ItemDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CalendarDayResponse {
    private String id;
    private String day;
    private ItemDto[] data;
    private Boolean[] dailyRoutine;
    private String[] gratitudeDiary;
    private String complimentForMeToday;
    private String todaysReflectionsAndImprovements;
    private String weeklyCode;
}