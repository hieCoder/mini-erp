package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.CommentTask;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class CommentTaskConverter {

    public CommentTaskResponse toResponse(CommentTask commentTask) {

        User user = commentTask.getUser();
        String avatarUser = null, fullnameUser = null;
        if(commentTask.getUser() != null){
            avatarUser = user.getAvatar();
            fullnameUser = user.getFullname();
        }

        return CommentTaskResponse.builder()
                .id(commentTask.getId())
                .content(commentTask.getContent())
                .createdDate(DateUtils.formatDateTime(commentTask.getCreatedDate()))
                .modifiedBy(commentTask.getModifiedBy())
                .modifiedDate(DateUtils.formatDateTime(commentTask.getModifiedDate()))
                .avatarUser(avatarUser)
                .fullnameUser(fullnameUser)
                .childComments(toListResponse(commentTask.getChildComments()))
                .build();
    }

    public List<CommentTaskResponse> toListResponse(List<CommentTask> commentTasks) {
        if(commentTasks == null) return null;
        return commentTasks.stream().map(c -> toResponse(c)).collect(Collectors.toList());
    }
}
