package com.shsoftvina.erpshsoftvina.model.response.task;

import com.shsoftvina.erpshsoftvina.model.dto.ActionChangeStatusTaskEnumDto;
import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentNotificationResponse;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TaskDetailResponse {
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
    private List<CommentTaskResponse> comments;
}
