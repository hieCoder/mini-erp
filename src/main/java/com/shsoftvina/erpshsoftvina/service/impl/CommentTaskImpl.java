package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.constant.CommentTaskConstant;
import com.shsoftvina.erpshsoftvina.constant.NotificationConstant;
import com.shsoftvina.erpshsoftvina.converter.CommentTaskConverter;
import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.entity.CommentTask;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.exception.FileTooLimitedException;
import com.shsoftvina.erpshsoftvina.exception.FileTypeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.CommentTaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
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

    @Override
    public CommentTaskResponse findById(String id) {
        CommentTask commentTask = commentTaskMapper.findById(id);
        return commentTaskConverter.toResponse(commentTask);
    }

    @Override
    public int createCommentTask(CreateCommentTaskRequest createCommentTaskRequest) {
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
            CommentTask commentTask = commentTaskConverter.toEntity(createCommentTaskRequest, listFileNameSaveFileSuccess);
            try{
                return commentTaskMapper.createCommentTask(commentTask);
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request,dir, commentTask.getFiles());
                return 0;
            }
        }
        return 0;
    }

    @Override
    public int updateCommentTask(UpdateCommentTaskRequest updateCommentTaskRequest) {
        if(commentTaskMapper.findById(updateCommentTaskRequest.getId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));

        MultipartFile[] files = updateCommentTaskRequest.getFiles();

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
            CommentTask commentTask = commentTaskConverter.toEntity(updateCommentTaskRequest, listFileNameSaveFileSuccess);
            try{
                return commentTaskMapper.updateCommentTask(commentTask);
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request,dir, commentTask.getFiles());
                return 0;
            }
        }
        return 0;
    }

    @Override
    public int deleteCommentTask(String id) {
        if(commentTaskMapper.findById(id) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));
        return commentTaskMapper.deleteById(id);
    }
}
