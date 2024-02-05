package com.shsoftvina.erpshsoftvina.model.dto.management_time;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DataOfDayDto {
    private ItemDto[] oneThingCalendar;
    private String[] gratitudeDiary;
    private String complimentForMeToday;
    private String todaysReflectionsAndImprovements;
    private String affirmation;
    private List<TodoDetailDto> toDoDetail;
    private Boolean[] dailyRoutine;
}
