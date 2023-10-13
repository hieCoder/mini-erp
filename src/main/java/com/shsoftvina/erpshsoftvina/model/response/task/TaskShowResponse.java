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
public class TaskShowResponse {

    private String id;
    private EnumDto statusTask;
    private String title;
    private String fullnameUser;
    private String startDate;
    private String dueOrCloseDate;
    private Integer progress;
    private EnumDto priority;
}