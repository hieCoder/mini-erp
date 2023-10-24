package com.shsoftvina.erpshsoftvina.model.request.managementtime.weekly;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WeeklyManagementTimeDayUpdateRequest {
    private String id;
    private String content;
}
