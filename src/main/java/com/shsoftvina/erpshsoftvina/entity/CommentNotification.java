package com.shsoftvina.erpshsoftvina.entity;

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
public class CommentNotification {
    private String id;
    private String content;
    private Date createdDate;
    private Notification notification;
    private User user;
    private Date modifiedDate;
    private String modifiedBy;
    private String parentId;
    private List<CommentNotification> childComments;
}

