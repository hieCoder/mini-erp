package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.CommentFeelingBook;
import com.hieDev.minierp.mapper.CommentFeelingBookMapper;
import com.hieDev.minierp.mapper.FeelingOfBookMapper;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.request.commentFeelingBook.CreateCommentFeelingBookRequest;
import com.hieDev.minierp.model.request.commentFeelingBook.UpdateCommentFeelingBookRequest;
import com.hieDev.minierp.model.response.commentfeelingbook.CommentFeelingBookResponse;
import com.hieDev.minierp.security.Principal;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class CommentFeelingBookConverter {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserConverter userConverter;

    @Autowired
    private FeelingOfBookMapper feelingOfBookMapper;

    @Autowired
    private CommentFeelingBookMapper commentFeelingBookMapper;

    public CommentFeelingBookResponse toResponse(CommentFeelingBook commentFeelingBook) {
        return CommentFeelingBookResponse.builder()
                .id(commentFeelingBook.getId())
                .content(commentFeelingBook.getContent())
                .createdDate(DateUtils.formatDateTime(commentFeelingBook.getCreatedDate()))
                .modifiedBy(commentFeelingBook.getModifiedBy())
                .modifiedDate(DateUtils.formatDateTime(commentFeelingBook.getModifiedDate()))
                .parentId(commentFeelingBook.getParentComment() != null?commentFeelingBook.getParentComment().getId(): null)
                .user(userConverter.toFullnameAndAvatarResponse(commentFeelingBook.getUser()))
                .childComments(toListResponse(commentFeelingBook.getChildComments()))
                .build();
    }

    public List<CommentFeelingBookResponse> toListResponse(List<CommentFeelingBook> commentFeelingBooks) {
        if(commentFeelingBooks == null) return null;
        return commentFeelingBooks.stream().map(c -> toResponse(c)).collect(Collectors.toList());
    }

    public CommentFeelingBook toEntity(CreateCommentFeelingBookRequest createCommentFeelingBookRequest) {
        return CommentFeelingBook.builder()
                .id(ApplicationUtils.generateId())
                .content(createCommentFeelingBookRequest.getContent())
                .createdDate(new Date())
                .user(userMapper.findById(createCommentFeelingBookRequest.getUserId()))
                .feelingOfBook(feelingOfBookMapper.findById(createCommentFeelingBookRequest.getFeelingBookId()))
                .parentComment(commentFeelingBookMapper.findById(createCommentFeelingBookRequest.getParentId()))
                .build();
    }

    public CommentFeelingBook toEntity(UpdateCommentFeelingBookRequest updateCommentFeelingBookRequest) {
        CommentFeelingBook commentFeelingBook = commentFeelingBookMapper.findById(updateCommentFeelingBookRequest.getId());
        commentFeelingBook.setContent(updateCommentFeelingBookRequest.getContent());
        commentFeelingBook.setModifiedBy(Principal.getUserCurrent().getFullname());
        commentFeelingBook.setModifiedDate(new Date());
        return commentFeelingBook;
    }
}
