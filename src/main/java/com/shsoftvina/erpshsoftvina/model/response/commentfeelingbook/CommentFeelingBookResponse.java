package com.shsoftvina.erpshsoftvina.model.response.commentfeelingbook;

import com.shsoftvina.erpshsoftvina.model.response.user.FullnameAndAvatarResponse;
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
