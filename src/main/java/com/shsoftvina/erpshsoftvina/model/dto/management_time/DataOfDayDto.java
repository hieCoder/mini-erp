package com.shsoftvina.erpshsoftvina.model.dto.management_time;

import com.shsoftvina.erpshsoftvina.model.response.managementtime.calendar.CalendarWeeklyContent;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DataOfDayDto {
    private OneThingCalendarDto oneThingCalendar;
    private ToDoListDto toDoList;
    private List<String> gratitudeDiary;
    private CalendarWeeklyContent todoListOnThisWeek;
    private String complimentForMeToday;
    private String todaysReflectionsAndImprovements;
    private String affirmation;
}
