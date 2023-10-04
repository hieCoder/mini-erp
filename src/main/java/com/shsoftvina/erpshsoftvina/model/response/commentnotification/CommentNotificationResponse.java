package com.shsoftvina.erpshsoftvina.model.response.commentnotification;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CommentNotificationResponse {
    private String id;
    private String content;
    private String createdDate;
    private String modifiedBy;
    private String modifiedDate;
    private String fullnameUser;
    private String avatarUser;
    private List<CommentNotificationResponse> childComments;
}
