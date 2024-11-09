package com.hieDev.minierp.entity;

import com.hieDev.minierp.enums.task.PriorityTaskEnum;
import com.hieDev.minierp.enums.task.StatusDeleteTaskEnum;
import com.hieDev.minierp.enums.task.StatusTaskEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Task {

    private String id;
    private StatusTaskEnum statusTask;
    private String title;
    private String content;
    private User user;
    private Date createdDate;
    private Date startDate;
    private Date dueDate;
    private Date closeDate;
    private Integer progress;
    private PriorityTaskEnum priority;
    private StatusDeleteTaskEnum status;
    private List<CommentTask> comments;
    private String tag;
    private String pic;
    private String relatedTask;
    private String filesTask;
}