package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.constant.SettingConstant;
import com.hieDev.minierp.constant.TaskConstant;
import com.hieDev.minierp.converter.TaskConverter;
import com.hieDev.minierp.exception.FileTooLimitedException;
import com.hieDev.minierp.exception.NotAllowException;
import com.hieDev.minierp.exception.NotFoundException;
import com.hieDev.minierp.model.request.task.TaskRegisterRequest;
import com.hieDev.minierp.model.request.task.TaskUpdateRequest;
import com.hieDev.minierp.entity.Setting;
import com.hieDev.minierp.entity.Task;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.enums.task.PriorityTaskEnum;
import com.hieDev.minierp.enums.task.StatusDeleteTaskEnum;
import com.hieDev.minierp.enums.task.StatusTaskEnum;
import com.hieDev.minierp.mapper.SettingMapper;
import com.hieDev.minierp.mapper.TaskMapper;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.response.task.DashboardTaskResponse;
import com.hieDev.minierp.model.response.task.StatusTaskCountsResponse;
import com.hieDev.minierp.model.response.task.TaskDetailResponse;
import com.hieDev.minierp.model.response.task.TaskShowResponse;
import com.hieDev.minierp.service.TaskService;
import com.hieDev.minierp.utils.*;
import com.shsoftvina.erpshsoftvina.utils.*;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
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

    @Autowired
    private SettingMapper settingMapper;

    @Override
    public List<TaskShowResponse> findAll(int start, int pageSize, String statusTask, String picSearch, String tagSearch, String titleSearch) {
        int offset = (start - 1) * pageSize;
        RowBounds rowBounds = new RowBounds(offset, pageSize);
        return taskMapper.findAll(statusTask, picSearch, tagSearch, titleSearch, rowBounds).stream().map(task -> taskConverter.toResponse(task)).collect(Collectors.toList());
    }

    @Override
    public long getTotalItem(String statusTask,  String picSearch, String tagSearch, String titleSearch) {
        return taskMapper.getTotalItem(statusTask, picSearch, tagSearch, titleSearch);
    }

    @Override
    public int registerTask(TaskRegisterRequest taskRegisterRequest) {

        String userId = taskRegisterRequest.getUserId();
        String priority = taskRegisterRequest.getPriority();

        User user = userMapper.findById(userId);
        if (user == null) throw new NotFoundException(MessageErrorUtils.notFound("userId"));
        if (!EnumUtils.isExistInEnum(PriorityTaskEnum.class, priority))
            throw new NotFoundException(MessageErrorUtils.notFound("Priority"));

        MultipartFile[] files = taskRegisterRequest.getFilesTask();
        String dir = TaskConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = null;

        if (files != null) {
            applicationUtils.checkValidateFile(Task.class, files);
            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(dir, files);
        } else {
            listFileNameSaveFileSuccess = new ArrayList<>();
        }

        if (listFileNameSaveFileSuccess != null) {
            Task task = taskConverter.toEntity(taskRegisterRequest, listFileNameSaveFileSuccess);

            try {
                taskMapper.registerTask(task);
                return 1;
            } catch (Exception e) {
            }
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

        MultipartFile[] newFiles = taskUpdateRequest.getFilesTask();
        String remainFiles = taskUpdateRequest.getRemainFiles();
        Setting setting = settingMapper.findByCode(SettingConstant.TASK_CODE);

        String dir = TaskConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = new ArrayList<>();

        if (newFiles != null) {
            applicationUtils.checkValidateFile(Task.class, newFiles);

            if (!StringUtils.isBlank(remainFiles)) {
                if((remainFiles.split(",").length + newFiles.length) > setting.getFileLimit()) {
                    throw new FileTooLimitedException(MessageErrorUtils.notAllowFileLimit(setting.getFileLimit()));
                }
            } else if(newFiles.length > setting.getFileLimit()){
                throw new FileTooLimitedException(MessageErrorUtils.notAllowFileLimit(setting.getFileLimit()));
            }

            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(dir, newFiles);
        }

        if (listFileNameSaveFileSuccess != null) {
            try {
                String newFilesToDB = null;
                if (StringUtils.isBlank(remainFiles)) {
                    newFilesToDB = String.join(",", listFileNameSaveFileSuccess);
                } else {
                    if(!listFileNameSaveFileSuccess.isEmpty()){
                        newFilesToDB = remainFiles + "," + String.join(",", listFileNameSaveFileSuccess);
                    } else newFilesToDB = remainFiles;
                }

                Task t = taskConverter.toEntity(taskUpdateRequest, newFilesToDB);
                taskMapper.updateTask(t);
                return 1;
            } catch (Exception e) {
            }
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
    public List<Map<String, Object>> findAllTitle() {
        return taskMapper.findAllTitle();
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