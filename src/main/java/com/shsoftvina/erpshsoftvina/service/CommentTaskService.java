package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.entity.CommentTask;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.CreateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.request.commenttask.UpdateCommentTaskRequest;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;

public interface CommentTaskService {
    CommentTaskResponse findById(String id);
    int createCommentTask(CreateCommentTaskRequest createCommentTaskRequest);
    int updateCommentTask(UpdateCommentTaskRequest updateCommentTaskRequest);
    int deleteCommentTask(String id);
}
