package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.constant.CommentTaskConstant;
import com.shsoftvina.erpshsoftvina.constant.NotificationConstant;
import com.shsoftvina.erpshsoftvina.converter.CommentTaskConverter;
import com.shsoftvina.erpshsoftvina.entity.*;
import com.shsoftvina.erpshsoftvina.exception.FileTooLimitedException;
import com.shsoftvina.erpshsoftvina.exception.FileTypeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.CommentTaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.CreateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.UpdateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;
import com.shsoftvina.erpshsoftvina.service.CommentTaskService;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
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

    @Override
    public CommentTaskResponse findById(String id) {
        CommentTask commentTask = commentTaskMapper.findById(id);
        return commentTaskConverter.toResponse(commentTask);
    }

    @Override
    public int createCommentTask(CreateCommentTaskRequest createCommentTaskRequest) {

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
            if(files.length > ApplicationConstant.NUMBER_UPLOAD_FILE_LIMIT) {
                throw new FileTooLimitedException(MessageErrorUtils.notAllowFileSize());
            }
            if(!FileUtils.isAllowedFileType(files, ApplicationConstant.LIST_TYPE_FILE)){
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType());
            }

            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, files);
        } else{
            listFileNameSaveFileSuccess = new ArrayList<>();
        }

        if(listFileNameSaveFileSuccess != null){
            CommentTask ct = commentTaskConverter.toEntity(createCommentTaskRequest, listFileNameSaveFileSuccess);
            try{
                return commentTaskMapper.createCommentTask(ct);
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request,dir, ct.getFiles());
                return 0;
            }
        }
        return 0;
    }

    @Override
    public int updateCommentTask(UpdateCommentTaskRequest updateCommentTaskRequest) {
        CommentTask commentTask = commentTaskMapper.findById(updateCommentTaskRequest.getId());
        if(commentTask == null)
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));

        MultipartFile[] files = updateCommentTaskRequest.getFiles();

        String dir = CommentTaskConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = null;

        String listFileNameOld = null;

        if (files!= null){
            if(files.length > ApplicationConstant.NUMBER_UPLOAD_FILE_LIMIT) {
                throw new FileTooLimitedException(MessageErrorUtils.notAllowFileSize());
            }
            if(!FileUtils.isAllowedFileType(files, ApplicationConstant.LIST_TYPE_FILE)){
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType());
            }

            listFileNameOld = commentTask.getFiles();
            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, files);
        } else{
            listFileNameSaveFileSuccess = new ArrayList<>();
        }

        if(listFileNameSaveFileSuccess != null){
            try{
                commentTaskMapper.updateCommentTask(commentTaskConverter.toEntity(updateCommentTaskRequest, listFileNameSaveFileSuccess));
                FileUtils.deleteMultipleFilesToServer(request, dir, listFileNameOld);
                return 1;
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request,dir, commentTask.getFiles());
                return 0;
            }
        }
        return 0;
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
