package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.commentFeelingBook.CreateCommentFeelingBookRequest;
import com.hieDev.minierp.model.request.commentFeelingBook.UpdateCommentFeelingBookRequest;
import com.hieDev.minierp.model.response.commentfeelingbook.CommentFeelingBookResponse;

public interface CommentFeelingBookService {
    CommentFeelingBookResponse createCommentFeeling(CreateCommentFeelingBookRequest createCommentFeelingBookRequest);
    CommentFeelingBookResponse updateCommentFeeling(UpdateCommentFeelingBookRequest updateCommentFeelingBookRequest);
    CommentFeelingBookResponse findById(String id);
    int deleteById(String id);
}
