package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Task;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.task.PriorityTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusDeleteTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusTaskEnum;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.response.task.StatusTaskCountsResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class TaskConverter {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CommentTaskConverter commentTaskConverter;

    public TaskShowResponse toResponse(Task task){

        Date closeDate = task.getCloseDate();
        String dueOrCloseDate = null;
        if(closeDate != null){
            if(!task.getStatusTask().equals(StatusTaskEnum.CLOSED)) dueOrCloseDate = "~ " + DateUtils.formatDate(task.getCloseDate());
            else dueOrCloseDate = DateUtils.formatDate(task.getCloseDate());
        }

        return TaskShowResponse.builder()
                .id(task.getId())
                .statusTask(EnumUtils.instance(task.getStatusTask()))
                .title(task.getTitle())
                .fullnameUser(task.getUser().getFullname())
                .startDate(DateUtils.formatDate(task.getStartDate()))
                .dueOrCloseDate(dueOrCloseDate)
                .progress(task.getProgress())
                .priority(EnumUtils.instance(task.getPriority()))
                .build();
    }

    public Task toEntity(TaskRegisterRequest taskRegisterRequest) {

        String userId = taskRegisterRequest.getUserId();
        String priority = taskRegisterRequest.getPriority();

        User user = userMapper.findById(userId);
        if (user == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));
        if (!EnumUtils.isExistInEnum(PriorityTaskEnum.class, priority)) throw new NotFoundException(MessageErrorUtils.notFound("Priority"));

        return Task.builder()
                .id(UUID.randomUUID().toString())
                .statusTask(StatusTaskEnum.REGISTERED)
                .title(taskRegisterRequest.getTitle())
                .content(taskRegisterRequest.getContent())
                .user(userMapper.findById(userId))
                .createdDate(new Date())
                .closeDate(taskRegisterRequest.getCloseDate())
                .priority(EnumUtils.getEnumFromValue(PriorityTaskEnum.class, priority))
                .progress(0)
                .status(StatusDeleteTaskEnum.ACTIVE)
                .build();
    }

    public List<StatusTaskCountsResponse> toListStatusTaskCountsResponse(List<Map<String, Object>> statusTaskCounts) {
        return statusTaskCounts.stream()
                .map(statusTaskCount -> {
                    String statusTask = (String) statusTaskCount.get("statusTask");
                    StatusTaskEnum statusEnum = EnumUtils.getEnumFromValue(StatusTaskEnum.class, statusTask);
                    long taskCount = (long) statusTaskCount.get("taskCount");
                    return new StatusTaskCountsResponse(EnumUtils.instance(statusEnum), taskCount);
                })
                .collect(Collectors.toList());
    }

    public TaskDetailResponse toDetailResponse(Task task){

        Date closeDate = task.getCloseDate();
        String dueOrCloseDate = null;
        if(closeDate != null){
            if(!task.getStatusTask().equals(StatusTaskEnum.CLOSED)) dueOrCloseDate = "~ " + DateUtils.formatDate(task.getCloseDate());
            else dueOrCloseDate = DateUtils.formatDate(task.getCloseDate());
        }

        return TaskDetailResponse.builder()
                .id(task.getId())
                .statusTask(ApplicationUtils.instance(task.getStatusTask()))
                .title(task.getTitle())
                .content(task.getContent())
                .fullnameUser(task.getUser().getFullname())
                .createdDate(DateUtils.formatDate(task.getCreatedDate()))
                .startDate(DateUtils.formatDate(task.getStartDate()))
                .dueOrCloseDate(dueOrCloseDate)
                .progress(task.getProgress())
                .priority(EnumUtils.instance(task.getPriority()))
                .comments(commentTaskConverter.toListResponse(task.getComments()))
                .build();
    }
}