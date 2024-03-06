package com.shsoftvina.erpshsoftvina.model.response.managementtime.day;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.YearTargetDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class YearResponse {
    private String year;
    private YearTargetDto[] target;
    private String grateful;
    private String happy;
    private String whoUBecome;
    private String personalGoal;
    private String commendable;
    private String keywords3;
    private String[] color;
}
