package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.CommentTask;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentTaskMapper {

    CommentTask findById(String id);
    int createCommentTask(CommentTask commentTask);
    int updateCommentTask(CommentTask commentTask);
    int deleteById(String id);
}
