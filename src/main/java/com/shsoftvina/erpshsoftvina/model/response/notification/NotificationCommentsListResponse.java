package com.shsoftvina.erpshsoftvina.model.response.notification;

import com.shsoftvina.erpshsoftvina.entity.CommentNotification;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NotificationCommentsListResponse {
    private String id;
    private String content;
    private String title;
    private String[] file;
    private List<CommentResponse> listComments;
}
