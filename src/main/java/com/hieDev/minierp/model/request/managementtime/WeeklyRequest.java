package com.hieDev.minierp.model.request.managementtime;

import com.hieDev.minierp.model.dto.management_time.WeeklyDto;
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
    private WeeklyDto[] weeklys;
    private String gratitudeDiary;
    private String compliment;
    private String reflectionAndImprovement;
}
