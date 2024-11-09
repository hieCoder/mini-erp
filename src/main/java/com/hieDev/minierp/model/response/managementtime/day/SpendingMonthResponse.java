package com.hieDev.minierp.model.response.managementtime.day;

import com.hieDev.minierp.model.dto.management_time.SpendingMonthItemDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SpendingMonthResponse {
    private Float spendingGoals;
    private SpendingMonthItemDto[] spending;
}
