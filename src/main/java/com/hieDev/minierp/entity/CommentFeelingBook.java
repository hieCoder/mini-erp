package com.hieDev.minierp.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentFeelingBook {
    private String id;
    private String content;
    private FeelingOfBook feelingOfBook;
    private User user;
    private CommentFeelingBook parentComment;
    private String modifiedBy;
    private Date createdDate;
    private Date modifiedDate;
    private List<CommentFeelingBook> childComments;
}
