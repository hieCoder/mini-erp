package com.shsoftvina.erpshsoftvina.model.response.commentnotification;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CommentResponse {
    private String id;
    private String content;
    private Date createdDate;
    private UserCommentResponse user;
    private String parentId;
    private List<CommentResponse> childComments;
}
