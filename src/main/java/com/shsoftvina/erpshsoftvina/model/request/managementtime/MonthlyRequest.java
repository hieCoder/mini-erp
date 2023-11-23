package com.shsoftvina.erpshsoftvina.model.request.managementtime;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.DailyRoutineDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MonthlyRequest {
    private String month;
    private String[] content;
    private DailyRoutineDto[] dailyRoutine;
}
