package com.hieDev.minierp.model.response.task;

import com.hieDev.minierp.model.dto.EnumDto;
import com.hieDev.minierp.model.dto.task.ActionChangeStatusTaskEnumDto;
import com.hieDev.minierp.model.dto.task.PicDto;
import com.hieDev.minierp.model.response.commenttask.CommentTaskResponse;
import com.hieDev.minierp.model.response.user.IdAndFullnameUserResponse;
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
    private IdAndFullnameUserResponse user;
    private String createdDate;
    private String startDate;
    private String dueDate;
    private String closeDate;
    private Integer progress;
    private EnumDto priority;
    private String content;
    private List<CommentTaskResponse> comments;
    private String tag;
    private PicDto[] pic;
    private String relatedTask;
    private String[] filesTask;
}
