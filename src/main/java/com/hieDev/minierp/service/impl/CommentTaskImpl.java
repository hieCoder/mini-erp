package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.constant.CommentTaskConstant;
import com.hieDev.minierp.constant.SettingConstant;
import com.hieDev.minierp.converter.CommentTaskConverter;
import com.hieDev.minierp.exception.FileTooLimitedException;
import com.hieDev.minierp.exception.NotFoundException;
import com.hieDev.minierp.entity.CommentTask;
import com.hieDev.minierp.entity.Setting;
import com.hieDev.minierp.entity.Task;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.mapper.CommentTaskMapper;
import com.hieDev.minierp.mapper.SettingMapper;
import com.hieDev.minierp.mapper.TaskMapper;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.request.commenttask.CreateCommentTaskRequest;
import com.hieDev.minierp.model.request.commenttask.UpdateCommentTaskRequest;
import com.hieDev.minierp.model.response.commenttask.CommentTaskResponse;
import com.hieDev.minierp.service.CommentTaskService;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.FileUtils;
import com.hieDev.minierp.utils.MessageErrorUtils;
import com.hieDev.minierp.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Service
public class CommentTaskImpl implements CommentTaskService {

    @Autowired
    CommentTaskMapper commentTaskMapper;

    @Autowired
    CommentTaskConverter commentTaskConverter;

    @Autowired
    private TaskMapper taskMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Autowired
    private SettingMapper settingMapper;

    @Override
    public CommentTaskResponse findById(String id) {
        CommentTask commentTask = commentTaskMapper.findById(id);
        return commentTaskConverter.toResponse(commentTask);
    }

    @Override
    public CommentTaskResponse createCommentTask(CreateCommentTaskRequest createCommentTaskRequest) {

        String taskId = createCommentTaskRequest.getTaskId();
        Task task = taskMapper.findById(taskId);
        if (task==null) throw new NotFoundException(MessageErrorUtils.notFound("taskID"));

        String userID = createCommentTaskRequest.getUserId();
        User user = userMapper.findById(userID);
        if (user==null) throw new NotFoundException(MessageErrorUtils.notFound("userID"));

        String parentId = createCommentTaskRequest.getParentId();
        CommentTask commentTask = null;
        if (parentId!=null){
            commentTask = commentTaskMapper.findById(parentId);
            if (commentTask==null) throw new NotFoundException(MessageErrorUtils.notFound("parentId"));
        }

        MultipartFile[] fileList = createCommentTaskRequest.getFileList();

        String dir = CommentTaskConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = null;

        if (fileList!= null){
            applicationUtils.checkValidateFile(CommentTask.class, fileList);

            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(dir, fileList);
        } else{
            listFileNameSaveFileSuccess = new ArrayList<>();
        }

        if(listFileNameSaveFileSuccess != null){
            CommentTask ct = commentTaskConverter.toEntity(createCommentTaskRequest, listFileNameSaveFileSuccess);
            try{
                commentTaskMapper.createCommentTask(ct);
                return commentTaskConverter.toResponse(ct);
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(dir, ct.getFiles());
                return null;
            }
        }
        return null;
    }

    @Override
    public CommentTaskResponse updateCommentTask(UpdateCommentTaskRequest updateCommentTaskRequest) {
        CommentTask commentTask = commentTaskMapper.findById(updateCommentTaskRequest.getId());
        if(commentTask == null) throw new NotFoundException(MessageErrorUtils.notFound("Id"));

        MultipartFile[] newFiles = updateCommentTaskRequest.getNewFiles();

        Setting setting = settingMapper.findByCode(SettingConstant.TASK_COMMENT_CODE);

        String remainFiles = updateCommentTaskRequest.getRemainFiles();

        String dir = CommentTaskConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = new ArrayList<>();

        if (newFiles!= null){

            applicationUtils.checkValidateFile(CommentTask.class, newFiles);

            if(!StringUtils.isBlank(remainFiles)){
                if((remainFiles.split(",").length + newFiles.length) > setting.getFileLimit()) {
                    throw new FileTooLimitedException(MessageErrorUtils.notAllowFileLimit(setting.getFileLimit()));
                }
            } else if(newFiles.length > setting.getFileLimit()){
                throw new FileTooLimitedException(MessageErrorUtils.notAllowFileLimit(setting.getFileLimit()));
            }

            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(dir, newFiles);
        }

        if(listFileNameSaveFileSuccess != null){
            try{
                String newFilesToDB = null;
                if(StringUtils.isBlank(remainFiles)){
                   newFilesToDB =  String.join(",", listFileNameSaveFileSuccess);
                } else{
                    if(!listFileNameSaveFileSuccess.isEmpty()){
                        newFilesToDB = remainFiles + "," + String.join(",", listFileNameSaveFileSuccess);
                    } else newFilesToDB = remainFiles;
                }

                CommentTask ct= commentTaskConverter.toEntity(updateCommentTaskRequest, newFilesToDB);
                commentTaskMapper.updateCommentTask(ct);
                String deleteFiles = StringUtils.getDifference(commentTask.getFiles(), remainFiles);
                FileUtils.deleteMultipleFilesToServer(dir, deleteFiles);
                return commentTaskConverter.toResponse(ct);
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(dir, String.join(",", listFileNameSaveFileSuccess));
                return null;
            }
        }
        return null;
    }

    @Override
    public int deleteCommentTask(String id) {
        CommentTask commentTask = commentTaskMapper.findById(id);
        if(commentTask == null)
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));
        try {
            commentTaskMapper.deleteById(id);
            String dir = CommentTaskConstant.UPLOAD_FILE_DIR;
            FileUtils.deleteMultipleFilesToServer(dir, commentTask.getFiles());
            return 1;
        } catch (Exception e){
        }
        return 0;
    }
}
