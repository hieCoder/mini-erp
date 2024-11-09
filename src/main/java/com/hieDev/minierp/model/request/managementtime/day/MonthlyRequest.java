package com.hieDev.minierp.model.request.managementtime.day;

import com.hieDev.minierp.model.dto.management_time.MonthlyContentDto;
import com.hieDev.minierp.model.dto.management_time.MonthlyTagetCategoryDto;
import com.hieDev.minierp.model.dto.management_time.TimeUsedMonthlyDto;
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
    private MonthlyTagetCategoryDto[] targetCategory;
    private String gratitudeDiary;
    private String compliment;
    private String reflectionAndImprovement;
    private TimeUsedMonthlyDto[] timeUsedMonthly;
}
