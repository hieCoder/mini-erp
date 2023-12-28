package com.shsoftvina.erpshsoftvina.model.dto.management_time;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SpendingMonthItemDto {
    private String day;
    private Float spending;
}
