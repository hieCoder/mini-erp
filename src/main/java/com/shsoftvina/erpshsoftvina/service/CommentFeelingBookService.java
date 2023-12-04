package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.commentFeelingBook.CreateCommentFeelingBookRequest;
import com.shsoftvina.erpshsoftvina.model.request.commentFeelingBook.UpdateCommentFeelingBookRequest;
import com.shsoftvina.erpshsoftvina.model.response.commentfeelingbook.CommentFeelingBookResponse;

public interface CommentFeelingBookService {
    CommentFeelingBookResponse createCommentFeeling(CreateCommentFeelingBookRequest createCommentFeelingBookRequest);
    CommentFeelingBookResponse updateCommentFeeling(UpdateCommentFeelingBookRequest updateCommentFeelingBookRequest);
    CommentFeelingBookResponse findById(String id);
    int deleteById(String id);
}
