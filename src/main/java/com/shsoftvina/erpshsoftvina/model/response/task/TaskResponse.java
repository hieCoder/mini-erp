package com.shsoftvina.erpshsoftvina.model.response.task;

import com.shsoftvina.erpshsoftvina.model.dto.ActionChangeStatusTaskEnumDto;
import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TaskResponse {

    private String id;
    private ActionChangeStatusTaskEnumDto statusTask;
    private String title;
    private String content;
    private String fullnameUser;
    private String createdDate;
    private String startDate;
    private String dueOrCloseDate;
    private Integer progress;
    private EnumDto priority;
}