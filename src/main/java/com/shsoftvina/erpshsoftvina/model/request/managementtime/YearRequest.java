package com.shsoftvina.erpshsoftvina.model.request.managementtime;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.YearTargetDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class YearRequest {
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
