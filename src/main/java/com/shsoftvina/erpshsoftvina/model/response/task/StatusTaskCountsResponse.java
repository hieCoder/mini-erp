package com.shsoftvina.erpshsoftvina.model.response.task;

import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
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
