package com.shsoftvina.erpshsoftvina.model.request.managementtime.day;

import com.shsoftvina.erpshsoftvina.model.dto.management_time.DataOfDayDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DayUpdateRequest {
    private String id;
    private DataOfDayDto data;
}
