package com.hieDev.minierp.model.response.feelingofbook;

import com.hieDev.minierp.model.response.commentfeelingbook.CommentFeelingBookResponse;
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
public class FeelingOfBookResponse {
    private String id;
    private String bookReport;
    private String createdDate;
    private Double timeSpentReading;
    private String note;
    private FullnameAndAvatarResponse user;
    private List<CommentFeelingBookResponse> comments;
}