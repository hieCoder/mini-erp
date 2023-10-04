package com.shsoftvina.erpshsoftvina.entity;

import com.shsoftvina.erpshsoftvina.enums.task.PriorityTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusDeleteTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusTaskEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

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
    private Date closeDate;
    private Integer progress;
    private PriorityTaskEnum priority;
    private StatusDeleteTaskEnum status;
}