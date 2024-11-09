package com.hieDev.minierp.model.response.managementtime.day;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DailyRoutineResponse {
    private String title;
    private int target;
    private int performance;
    private String rate;
}
