package com.hieDev.minierp.model.request.managementtime.day;

import com.hieDev.minierp.model.dto.management_time.SpendingMonthItemDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SpendingMonthRequest {
    private String userId;
    private String month;
    private Float spendingGoals;
    private SpendingMonthItemDto[] days;
}
