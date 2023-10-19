package com.shsoftvina.erpshsoftvina.model.response.notification;

import com.shsoftvina.erpshsoftvina.entity.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NotificationShowResponse {
    private String id;
    private String content;
    private String title;
    private String[] files;
    private String createdDate;
    private User user;
}
