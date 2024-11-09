package com.hieDev.minierp.model.response.managementtime.day;

import com.hieDev.minierp.model.dto.management_time.YearTargetDto;
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
    private String selfInspiration;
    private String[] color;
}
