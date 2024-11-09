package com.hieDev.minierp.model.dto.management_time;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class YearTargetDto {
    private String target;
    private String status;
    private YearContentNodeDto[] contentNode;
}