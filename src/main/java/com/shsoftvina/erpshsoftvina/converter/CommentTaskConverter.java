package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.entity.CommentTask;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.CommentTaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.commentnotification.CreateCommentNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.CreateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.UpdateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.StringUtils;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class CommentTaskConverter {

    @Autowired
    CommentTaskMapper commentTaskMapper;

    @Autowired
    TaskMapper taskMapper;

    @Autowired
    UserMapper userMapper;

    public CommentTaskResponse toResponse(CommentTask commentTask) {

        if(commentTask == null) return null;

        User user = commentTask.getUser();
        String avatarUser = null, fullnameUser = null;
        if(commentTask.getUser() != null){
            avatarUser = user.getAvatar();
            fullnameUser = user.getFullname();
        }

        return CommentTaskResponse.builder()
                .id(commentTask.getId())
                .content(commentTask.getContent())
                .files(StringUtils.splitPathFile(CommentTask.class, commentTask.getFiles(), ","))
                .createdDate(DateUtils.formatDateTime(commentTask.getCreatedDate()))
                .modifiedBy(commentTask.getModifiedBy())
                .modifiedDate(DateUtils.formatDateTime(commentTask.getModifiedDate()))
                .avatarUser(avatarUser)
                .fullnameUser(fullnameUser)
                .childComments(toListResponse(commentTask.getChildComments()))
                .build();
    }

    public CommentTask toEntity(CreateCommentTaskRequest createCommentTaskRequest, List<String> listFileNameSaveFileSuccess) {
        String files = null;
        if(!listFileNameSaveFileSuccess.isEmpty()){
            files = String.join(",", listFileNameSaveFileSuccess);
        }
        return CommentTask.builder()
                .id(UUID.randomUUID().toString())
                .content(createCommentTaskRequest.getContent())
                .files(files)
                .createdDate(new Date())
                .task(taskMapper.findById(createCommentTaskRequest.getTaskId()))
                .user(userMapper.findById(createCommentTaskRequest.getUserId()))
                .parentComment(commentTaskMapper.findById(createCommentTaskRequest.getParentId()))
                .build();
    }

    public CommentTask toEntity(UpdateCommentTaskRequest updateCommentTaskRequest, List<String> listFileNameSaveFileSuccess) {
        String files = null;
        if(!listFileNameSaveFileSuccess.isEmpty()){
            files = String.join(",", listFileNameSaveFileSuccess);
        }
        return CommentTask.builder()
                .id(updateCommentTaskRequest.getId())
                .content(updateCommentTaskRequest.getContent())
                .files(files)
                .modifiedDate(new Date())
                .modifiedBy(Principal.getUserCurrent().getFullname())
                .build();
    }

    public List<CommentTaskResponse> toListResponse(List<CommentTask> commentTasks) {
        if(commentTasks == null) return null;
        return commentTasks.stream().map(c -> toResponse(c)).collect(Collectors.toList());
    }
}
