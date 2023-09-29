package com.shsoftvina.erpshsoftvina.model.response.notification;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NotificationResponse {
    private String id;
    private String title;
    private String content;
    private String[] file;
    private String createDate;
}
