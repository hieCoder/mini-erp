package com.shsoftvina.erpshsoftvina.model.response.managementtime.day;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.DailyRoutineDto;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.DataOfDayDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MonthResponse {
    private String[] monthlyContents;
    private DailyRoutineDto[] dailyRoutine;
}