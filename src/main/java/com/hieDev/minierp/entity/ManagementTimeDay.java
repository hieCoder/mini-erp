package com.hieDev.minierp.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ManagementTimeDay {
    private String id;
    private String oneThingCalendar;
    private String gratitudeDiary;
    private String affirmation;
    private String complimentForMeToday;
    private String todaysReflectionsAndImprovements;
    private String toDoDetail;
    private String dailyRoutine;
    private Date day;
    private User user;
    private String weeklyCode;
    private boolean isAllowedNoti;
    private String contentNoti;
    private Float spending;
}
