package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.converter.CommentFeelingBookConverter;
import com.hieDev.minierp.entity.CommentFeelingBook;
import com.hieDev.minierp.mapper.CommentFeelingBookMapper;
import com.hieDev.minierp.model.request.commentFeelingBook.CreateCommentFeelingBookRequest;
import com.hieDev.minierp.model.request.commentFeelingBook.UpdateCommentFeelingBookRequest;
import com.hieDev.minierp.model.response.commentfeelingbook.CommentFeelingBookResponse;
import com.hieDev.minierp.service.CommentFeelingBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentFeelingBookServiceImpl implements CommentFeelingBookService {

    @Autowired
    private CommentFeelingBookMapper commentFeelingBookMapper;

    @Autowired
    private CommentFeelingBookConverter commentFeelingBookConverter;

    @Override
    public CommentFeelingBookResponse createCommentFeeling(CreateCommentFeelingBookRequest createCommentFeelingBookRequest) {
        try {
            CommentFeelingBook commentFeelingBook = commentFeelingBookConverter.toEntity(createCommentFeelingBookRequest);
            commentFeelingBookMapper.createCommentFeeling(commentFeelingBook);
            return commentFeelingBookConverter.toResponse(commentFeelingBook);
        } catch (Exception e) {
            throw new RuntimeException("Error Create CommentFeeling: ", e);
        }
    }

    @Override
    public CommentFeelingBookResponse updateCommentFeeling(UpdateCommentFeelingBookRequest updateCommentFeelingBookRequest) {
        try {
            CommentFeelingBook commentFeelingBook = commentFeelingBookConverter.toEntity(updateCommentFeelingBookRequest);
            commentFeelingBookMapper.updateCommentFeeling(commentFeelingBook);
            return commentFeelingBookConverter.toResponse(commentFeelingBook);
        } catch (Exception e) {
           throw new RuntimeException("Error Update CommentFeeling: " + e);
        }

    }

    @Override
    public CommentFeelingBookResponse findById(String id) {
        return commentFeelingBookConverter.toResponse(commentFeelingBookMapper.findById(id));
    }

    @Override
    public int deleteById(String id) {
        try {
            commentFeelingBookMapper.deleteById(id);
            return 1;
        } catch (Exception e) {
            throw new RuntimeException("Error Update CommentFeeling: " + e);
        }
    }
}
