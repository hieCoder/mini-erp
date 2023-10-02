package com.shsoftvina.erpshsoftvina.model.request.commentnotification;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateCommentRequest {
    private String notificationId;
    private String content;
    private String parentId;
    private String userId;
}


