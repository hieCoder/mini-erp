package com.shsoftvina.erpshsoftvina.model.request.managementtime;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.WeeklyDto;
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
