package com.shsoftvina.erpshsoftvina.model.response.notification;

import com.shsoftvina.erpshsoftvina.enums.Notification.StatusNotificationEnum;
import com.shsoftvina.erpshsoftvina.model.response.commentnotification.CommentNotificationResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NotificationDetailResponse {
    private String id;
    private StatusNotificationEnum status;
    private String content;
    private String title;
    private String[] files;
    private String createdDate;
    private String fullnameUser;
    private String idUser;
    private List<CommentNotificationResponse> comments;
    private String categoryPush;
}
