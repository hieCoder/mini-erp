package com.hieDev.minierp.model.request.managementtime.day;

import com.hieDev.minierp.model.dto.management_time.QuoteDto;
import com.hieDev.minierp.model.request.managementtime.WeeklyRequest;
import com.hieDev.minierp.model.request.managementtime.WeeklyRequestReview;
import com.hieDev.minierp.model.request.managementtime.YearRequest;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DaysUpdateRequest {
    private String userId;
    private MonthlyRequest monthly;
    private WeeklyRequest weekly;
    private List<WeeklyRequestReview> weeklysReview;
    private DayRequest[] days;
    private ColorRequest[] colors;
    private QuoteDto quotes;
    private YearRequest year;
}