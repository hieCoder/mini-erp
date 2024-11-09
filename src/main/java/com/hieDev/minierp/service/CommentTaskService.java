package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.commenttask.CreateCommentTaskRequest;
import com.hieDev.minierp.model.request.commenttask.UpdateCommentTaskRequest;
import com.hieDev.minierp.model.response.commenttask.CommentTaskResponse;

public interface CommentTaskService {
    CommentTaskResponse findById(String id);
    CommentTaskResponse createCommentTask(CreateCommentTaskRequest createCommentTaskRequest);
    CommentTaskResponse updateCommentTask(UpdateCommentTaskRequest updateCommentTaskRequest);
    int deleteCommentTask(String id);
}
