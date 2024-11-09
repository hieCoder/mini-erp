package com.hieDev.minierp.model.response.managementtime.day;

import com.hieDev.minierp.model.dto.management_time.DataOfDayDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DayResponse {
    private String id;
    private String day;
    private DataOfDayDto data;
}