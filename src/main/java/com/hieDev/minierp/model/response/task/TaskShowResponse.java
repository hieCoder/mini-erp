package com.hieDev.minierp.model.response.task;

import com.hieDev.minierp.model.dto.EnumDto;
import com.hieDev.minierp.model.dto.task.PicDto;
import com.hieDev.minierp.model.response.user.IdAndFullnameUserResponse;
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
    private IdAndFullnameUserResponse user;
    private String startDate;
    private String dueOrCloseDate;
    private Integer progress;
    private EnumDto priority;
    private String tag;
    private PicDto[] pic;
    private String relatedTask;
    private String[] filesTask;
}