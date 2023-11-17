package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.CommentTask;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CommentTaskMapper {

    CommentTask findById(String id);
    int createCommentTask(CommentTask commentTask);
    int updateCommentTask(CommentTask commentTask);
    int deleteById(String id);
}
