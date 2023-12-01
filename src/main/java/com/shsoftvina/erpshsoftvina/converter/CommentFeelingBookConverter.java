package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.CommentFeelingBook;
import com.shsoftvina.erpshsoftvina.model.response.commentfeelingbook.CommentFeelingBookResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class CommentFeelingBookConverter {

    @Autowired
    private UserConverter userConverter;

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
        return commentFeelingBooks.stream().map(c -> toResponse(c)).collect(Collectors.toList());
    }
}
