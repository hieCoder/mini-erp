package com.shsoftvina.erpshsoftvina.model.response.feelingofbook;

import com.shsoftvina.erpshsoftvina.model.response.commentfeelingbook.CommentFeelingBookResponse;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.FullnameAndAvatarResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FeelingOfBookResponse {
    private String id;
    private String feeling;
    private String quote;
    private String lesson;
    private String action;
    private String createdDate;
    private FullnameAndAvatarResponse user;
    private List<CommentFeelingBookResponse> comments;
}