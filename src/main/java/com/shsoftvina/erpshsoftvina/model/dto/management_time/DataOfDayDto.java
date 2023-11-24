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
    private OneThingCalendarDto oneThingCalendar= new OneThingCalendarDto();
    private ToDoListDto toDoList = new ToDoListDto();
    private String[] gratitudeDiary;
    private String complimentForMeToday;
    private String todaysReflectionsAndImprovements;
    private String affirmation;
    private String[] toDoDetail;
    private Boolean[] dailyRoutine;
}
