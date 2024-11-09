package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.CommentFeelingBook;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentFeelingBookMapper {
    int createCommentFeeling(CommentFeelingBook commentFeelingBook);
    int updateCommentFeeling(CommentFeelingBook commentFeelingBook);
    int deleteById(String id);
    CommentFeelingBook findById(String id);
}
