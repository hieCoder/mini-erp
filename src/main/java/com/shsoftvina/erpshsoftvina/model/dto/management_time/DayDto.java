package com.shsoftvina.erpshsoftvina.model.dto.management_time;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DayDto {
    private Date day;
    private DataOfDayDto data;
    private String userId;
}
