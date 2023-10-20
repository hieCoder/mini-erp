package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.CommentTaskConstant;
import com.shsoftvina.erpshsoftvina.constant.SettingConstant;
import com.shsoftvina.erpshsoftvina.converter.CommentTaskConverter;
import com.shsoftvina.erpshsoftvina.entity.CommentTask;
import com.shsoftvina.erpshsoftvina.entity.Setting;
import com.shsoftvina.erpshsoftvina.entity.Task;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.exception.FileSizeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.FileTooLimitedException;
import com.shsoftvina.erpshsoftvina.exception.FileTypeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.CommentTaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.SettingMapper;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.CreateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.UpdateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;
import com.shsoftvina.erpshsoftvina.service.CommentTaskService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import com.shsoftvina.erpshsoftvina.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service
public class CommentTaskImpl implements CommentTaskService {

    @Autowired
    CommentTaskMapper commentTaskMapper;

    @Autowired
    CommentTaskConverter commentTaskConverter;

    @Autowired
    private HttpServletRequest request;

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

        MultipartFile[] files = createCommentTaskRequest.getFiles();

        String dir = CommentTaskConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = null;

        if (files!= null){
            applicationUtils.checkValidateFile(CommentTask.class, files);

            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, files);
        } else{
            listFileNameSaveFileSuccess = new ArrayList<>();
        }

        if(listFileNameSaveFileSuccess != null){
            CommentTask ct = commentTaskConverter.toEntity(createCommentTaskRequest, listFileNameSaveFileSuccess);
            try{
                commentTaskMapper.createCommentTask(ct);
                return commentTaskConverter.toResponse(ct);
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request,dir, ct.getFiles());
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

        if(newFiles != null){
            for(MultipartFile file: newFiles){
                if (!FileUtils.isAllowedFileSize(file)) throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize());
            }
            if(!FileUtils.isAllowedFileType(newFiles, setting.getFileType())){
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType(setting.getFileType()));
            }
        }

        String remainFiles = updateCommentTaskRequest.getRemainFiles();

        String dir = CommentTaskConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = new ArrayList<>();

        if (newFiles!= null){

            if(!StringUtils.isBlank(remainFiles)){
                if((remainFiles.split(",").length + newFiles.length) > setting.getFileSize()) {
                    throw new FileTooLimitedException(MessageErrorUtils.notAllowFileLimit(setting.getFileSize()));
                }
            } else if(newFiles.length > setting.getFileSize()){
                throw new FileTooLimitedException(MessageErrorUtils.notAllowFileLimit(setting.getFileSize()));
            }

            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, newFiles);
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
                FileUtils.deleteMultipleFilesToServer(request, dir, deleteFiles);
                return commentTaskConverter.toResponse(ct);
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request,dir, String.join(",", listFileNameSaveFileSuccess));
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
            FileUtils.deleteMultipleFilesToServer(request, dir, commentTask.getFiles());
            return 1;
        } catch (Exception e){
        }
        return 0;
    }
}
