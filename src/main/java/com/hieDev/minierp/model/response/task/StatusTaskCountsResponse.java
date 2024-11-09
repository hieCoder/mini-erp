package com.hieDev.minierp.model.response.task;

import com.hieDev.minierp.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StatusTaskCountsResponse {
    private EnumDto statusTask;
    private long taskCount;
}
