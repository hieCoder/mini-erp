package com.shsoftvina.erpshsoftvina.model.request.managementtime.day;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.MonthlyContentDto;
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
    private MonthlyContentDto[] content;
    private DailyRoutineRequest[] dailyRoutine;
    private CostsRequest[] costs;
}
