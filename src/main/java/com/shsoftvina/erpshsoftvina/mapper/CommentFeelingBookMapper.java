package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.CommentFeelingBook;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentFeelingBookMapper {
    int createCommentFeeling(CommentFeelingBook commentFeelingBook);
}
