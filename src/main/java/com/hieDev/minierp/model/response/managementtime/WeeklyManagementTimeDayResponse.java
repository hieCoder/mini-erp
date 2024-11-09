package com.hieDev.minierp.model.response.managementtime;

import com.hieDev.minierp.model.dto.management_time.WeeklyDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WeeklyManagementTimeDayResponse {
    private String weeklyId;
    private String startDate;
    private WeeklyDto[] weeklys;
    private String gratitudeDiary;
    private String compliment;
    private String reflectionAndImprovement;
}
