package com.hieDev.minierp.model.request.managementtime.day;

import com.hieDev.minierp.model.dto.management_time.DataOfDayDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DayRequest {
    private Date day;
    private DataOfDayDto data;
}
