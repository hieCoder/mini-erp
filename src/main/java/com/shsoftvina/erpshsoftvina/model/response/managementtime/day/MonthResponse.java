package com.shsoftvina.erpshsoftvina.model.response.managementtime.day;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.MonthlyContentDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MonthResponse {
    private String month;
    private MonthlyContentDto[] monthlyContents;
    private DailyRoutineResponse[] dailyRoutine;
    private List<CostResponse> incomes;
    private List<CostResponse> fixeds;
    private List<CostResponse> fluctuatings;
}