package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Task;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.task.ActionChangeStatusTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.PriorityTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusDeleteTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusTaskEnum;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.task.StatusTaskCountsResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import liquibase.pro.packaged.D;
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

    @Autowired
    private TaskMapper taskMapper;

    public TaskShowResponse toResponse(Task task){

        if (task == null) return null;

        Date dueDate = task.getDueDate();
        String dueOrCloseDate = null;
        if(dueDate != null){
            if(!task.getStatusTask().equals(StatusTaskEnum.CLOSED)) dueOrCloseDate = "~ " + DateUtils.formatDate(task.getDueDate());
            else dueOrCloseDate = DateUtils.formatDate(task.getCloseDate());
        }

        return TaskShowResponse.builder()
                .id(task.getId())
                .statusTask(EnumUtils.instance(task.getStatusTask()))
                .title(task.getTitle())
                .fullnameUser(task.getUser()!=null?task.getUser().getFullname():null)
                .startDate(DateUtils.formatDate(task.getStartDate()))
                .dueOrCloseDate(dueOrCloseDate)
                .progress(task.getProgress())
                .priority(EnumUtils.instance(task.getPriority()))
                .build();
    }

    public Task toEntity(TaskRegisterRequest taskRegisterRequest) {

        return Task.builder()
                .id(UUID.randomUUID().toString())
                .statusTask(StatusTaskEnum.REGISTERED)
                .title(taskRegisterRequest.getTitle())
                .content(taskRegisterRequest.getContent())
                .user(userMapper.findById(taskRegisterRequest.getUserId()))
                .createdDate(new Date())
                .dueDate(taskRegisterRequest.getDueDate())
                .priority(EnumUtils.getEnumFromValue(PriorityTaskEnum.class,
                        taskRegisterRequest.getPriority()))
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

        if (task == null) return null;

        return TaskDetailResponse.builder()
                .id(task.getId())
                .statusTask(ApplicationUtils.instance(task.getStatusTask()))
                .title(task.getTitle())
                .idUser(task.getUser().getId())
                .fullnameUser(task.getUser().getFullname())
                .createdDate(DateUtils.formatDate(task.getCreatedDate()))
                .startDate(DateUtils.formatDate(task.getStartDate()))
                .dueDate(DateUtils.formatDate(task.getDueDate()))
                .closeDate(DateUtils.formatDate(task.getCloseDate()))
                .progress(task.getProgress())
                .priority(EnumUtils.instance(task.getPriority()))
                .content(task.getContent())
                .comments(commentTaskConverter.toListResponse(task.getComments()))
                .build();
    }

    public Task toEntity(TaskUpdateRequest taskUpdateRequest) {

        String id = taskUpdateRequest.getId();
        String action = taskUpdateRequest.getAction();
        Integer progress = taskUpdateRequest.getProgress();
        Date dueDate = taskUpdateRequest.getDueDate();

        Task task = taskMapper.findById(id);

        Date startDate = task.getStartDate();
        if (action.equals(ActionChangeStatusTaskEnum.OPEN.toString()) && startDate== null){
            startDate = new Date();
        }

        StatusTaskEnum statusTaskCurrent = task.getStatusTask();
        StatusTaskEnum statusTaskNew = ApplicationUtils.getNextStatusTaskEnum(statusTaskCurrent, action);

        Date closeDate = task.getCloseDate();

        if(task.getStatusTask().equals(StatusTaskEnum.OPENED) || task.getStatusTask().equals(StatusTaskEnum.REOPENED)){
            if(progress == 100) {
                statusTaskNew = StatusTaskEnum.CLOSED;
                closeDate = new Date();
            }
            if (statusTaskNew.equals(StatusTaskEnum.CLOSED)) {
                progress = 100;
                closeDate = new Date();
            }
        } else if (!task.getStatusTask().equals(StatusTaskEnum.REOPENED) && statusTaskNew.equals(StatusTaskEnum.REOPENED)){
            progress = 0;
            closeDate = null;
        }

        return Task.builder()
                .id(id)
                .statusTask(statusTaskNew)
                .title(taskUpdateRequest.getTitle())
                .content(taskUpdateRequest.getContent())
                .startDate(startDate)
                .priority(EnumUtils.getEnumFromValue(PriorityTaskEnum.class, taskUpdateRequest.getPriority()))
                .progress(progress)
                .closeDate(closeDate)
                .dueDate(dueDate)
                .build();
    }
}