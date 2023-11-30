package com.shsoftvina.erpshsoftvina.model.response.managementtime;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.WeeklyDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WeeklyManagementTimeDayResponse {
    private String weeklyId;
    private String startDate;
    private WeeklyDto[] weeklys;
}
