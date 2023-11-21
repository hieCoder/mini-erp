package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.CommentTask;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.mapper.CommentTaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.CreateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.UpdateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.StringUtils;
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
            avatarUser = FileUtils.getPathUpload(User.class, user.getAvatar());
            fullnameUser = user.getFullname();
        }

        return CommentTaskResponse.builder()
                .id(commentTask.getId())
                .title(commentTask.getTitle())
                .content(commentTask.getContent())
                .files(FileUtils.getPathUploadList(CommentTask.class, commentTask.getFiles()))
                .createdDate(DateUtils.formatDateTime(commentTask.getCreatedDate()))
                .modifiedBy(commentTask.getModifiedBy())
                .modifiedDate(DateUtils.formatDateTime(commentTask.getModifiedDate()))
                .parentId(commentTask.getParentComment() != null?commentTask.getParentComment().getId(): null)
                .avatarUser(avatarUser)
                .fullnameUser(fullnameUser)
                .idUser(commentTask.getUser().getId())
                .childComments(toListResponse(commentTask.getChildComments()))
                .build();
    }

    public CommentTask toEntity(CreateCommentTaskRequest createCommentTaskRequest, List<String> listFileNameSaveFileSuccess) {
        String files = null;
        if(!listFileNameSaveFileSuccess.isEmpty()){
            files = String.join(",", listFileNameSaveFileSuccess);
        }
        return CommentTask.builder()
                .id(ApplicationUtils.generateId())
                .title(createCommentTaskRequest.getTitle())
                .content(createCommentTaskRequest.getContent())
                .files(files)
                .createdDate(new Date())
                .task(taskMapper.findById(createCommentTaskRequest.getTaskId()))
                .user(userMapper.findById(createCommentTaskRequest.getUserId()))
                .parentComment(commentTaskMapper.findById(createCommentTaskRequest.getParentId()))
                .build();
    }

    public CommentTask toEntity(UpdateCommentTaskRequest updateCommentTaskRequest, String newFilesToDB) {

        CommentTask commentTask = commentTaskMapper.findById(updateCommentTaskRequest.getId());
        commentTask.setTitle(updateCommentTaskRequest.getTitle());
        commentTask.setContent(updateCommentTaskRequest.getContent());
        commentTask.setFiles(newFilesToDB);
        commentTask.setModifiedDate(new Date());
        commentTask.setModifiedBy(Principal.getUserCurrent().getFullname());
        return commentTask;
    }

    public List<CommentTaskResponse> toListResponse(List<CommentTask> commentTasks) {
        if(commentTasks == null) return null;
        return commentTasks.stream().map(c -> toResponse(c)).collect(Collectors.toList());
    }
}
