package com.hieDev.minierp.model.response.commentfeelingbook;

import com.hieDev.minierp.model.response.user.FullnameAndAvatarResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentFeelingBookResponse {
    private String id;
    private String content;
    private FullnameAndAvatarResponse user;
    private String parentId;
    private String modifiedBy;
    private String createdDate;
    private String modifiedDate;
    private List<CommentFeelingBookResponse> childComments;
}
