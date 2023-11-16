package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.TaskConverter;
import com.shsoftvina.erpshsoftvina.entity.Task;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.task.PriorityTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusDeleteTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.exception.NotAllowException;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.exception.UnauthorizedException;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.request.task.TaskUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.task.DashboardTaskResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.StatusTaskCountsResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.TaskService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import com.shsoftvina.erpshsoftvina.utils.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class TaskServiceImpl implements TaskService {

    @Autowired
    TaskMapper taskMapper;

    @Autowired
    TaskConverter taskConverter;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Override
    public List<TaskShowResponse> findAll(int start, int pageSize, String statusTask, String search) {
        int offset = (start - 1) * pageSize;
        RowBounds rowBounds = new RowBounds(offset, pageSize);
        return taskMapper.findAll(statusTask, search, rowBounds).stream().map(task -> taskConverter.toResponse(task)).collect(Collectors.toList());
    }

    @Override
    public long getTotalItem(String statusTask, String search) {
        return taskMapper.getTotalItem(statusTask, search);
    }

    @Override
    public int registerTask(TaskRegisterRequest taskRegisterRequest) {

        String userId = taskRegisterRequest.getUserId();
        String priority = taskRegisterRequest.getPriority();

        User user = userMapper.findById(userId);
        if (user == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));
        if (!EnumUtils.isExistInEnum(PriorityTaskEnum.class, priority))
            throw new NotFoundException(MessageErrorUtils.notFound("Priority"));

        try {
            taskMapper.registerTask(taskConverter.toEntity(taskRegisterRequest));
            return 1;
        } catch (Exception e) {
        }
        return 0;
    }

    @Override
    public int updateTask(TaskUpdateRequest taskUpdateRequest) {

        String id = taskUpdateRequest.getId();

        Task task = taskMapper.findById(id);
        if (task == null) throw new NotFoundException(MessageErrorUtils.notFound("Id"));

        if(userMapper.findById(taskUpdateRequest.getUserId()) == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        if (!EnumUtils.isExistInEnum(PriorityTaskEnum.class, taskUpdateRequest.getPriority()))
            throw new NotFoundException(MessageErrorUtils.notFound("Priority"));

        String action = taskUpdateRequest.getAction();
        boolean isActionValidForUpdateStatusTask = ApplicationUtils.isActionValidForUpdateStatusTask(task.getStatusTask(), action);
        if (!isActionValidForUpdateStatusTask) throw new NotAllowException(MessageErrorUtils.notAllow("Action"));

        if (taskUpdateRequest.getProgress() != task.getProgress() &&
                (task.getStatusTask().equals(StatusTaskEnum.REGISTERED) ||
                        task.getStatusTask().equals(StatusTaskEnum.POSTPONED) ||
                        task.getStatusTask().equals(StatusTaskEnum.CLOSED))
        ) throw new NotAllowException(MessageErrorUtils.notAllow("Progress"));

        if(task.getStatus().equals(StatusTaskEnum.REGISTERED) && taskUpdateRequest.getAction() != null && taskUpdateRequest.getDueDate() == null)
            throw new NotAllowException(MessageErrorUtils.notAllow("Due date"));

        try {
            Task t = taskConverter.toEntity(taskUpdateRequest);
            taskMapper.updateTask(t);
            return 1;
        } catch (Exception e) {
        }
        return 0;
    }

    @Override
    public int deleteById(String id) {
        if (taskMapper.findById(id) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));
        return taskMapper.changeStatusTask(id, StatusDeleteTaskEnum.INACTIVE.toString());
    }

    @Override
    public List<StatusTaskCountsResponse> getStatusTaskCount() {
        return taskConverter.toListStatusTaskCountsResponse(taskMapper.getStatusTaskCounts());
    }

    @Override
    public TaskDetailResponse findById(String id) {
        Task task = taskMapper.findById(id);
        if (task.getStatus().equals(StatusDeleteTaskEnum.INACTIVE)){
            applicationUtils.checkUserAllow();
        }
        return taskConverter.toDetailResponse(task);
    }

    @Override
    public List<Map<String, Object>> getTaskByTitle(String userId, String title) {
        return taskMapper.getTaskByTitle(userId, title);
    }

    @Override
    public int deleteByIds(String[] ids) {
        for(String id: ids){
            if (taskMapper.findById(id) == null)
                throw new NotFoundException(MessageErrorUtils.notFound("Id"));
        }
        return taskMapper.changeStatusTasks(ids, StatusDeleteTaskEnum.INACTIVE.toString());
    }

    @Override
    public DashboardTaskResponse getOpenedTask(String userId) {
        DashboardTaskResponse dashboardTask = new DashboardTaskResponse();
        dashboardTask.setStatusTaskCounts(taskConverter.toListStatusTaskCountsResponse(taskMapper.getOpenedStatusTaskCounts(userId)));
        List<TaskShowResponse> list = taskMapper.getOpenedTask(userId).stream().map(task -> taskConverter.toResponse(task)).collect(Collectors.toList());
        dashboardTask.setResponseList(list);
        return dashboardTask;
    }
}