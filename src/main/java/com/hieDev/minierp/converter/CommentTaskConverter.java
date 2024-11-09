package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.CommentTask;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.mapper.CommentTaskMapper;
import com.hieDev.minierp.mapper.TaskMapper;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.request.commenttask.CreateCommentTaskRequest;
import com.hieDev.minierp.model.request.commenttask.UpdateCommentTaskRequest;
import com.hieDev.minierp.model.response.commenttask.CommentTaskResponse;
import com.hieDev.minierp.security.Principal;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.DateUtils;
import com.hieDev.minierp.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
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
