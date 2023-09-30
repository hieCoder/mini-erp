package com.shsoftvina.erpshsoftvina.converter.notification;

import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class NotificationConverter {

    public NotificationResponse toResponse(Notification notification) {
        return NotificationResponse.builder()
                .id(notification.getId())
                .title(notification.getTitle())
                .content(notification.getContent())
                .file(notification.getFile().split(","))
                .createDate(DateUtils.formatDateTime(notification.getCreateDate()))
                .build();
    }

    public Notification toEntity (CreateNotificationRequest updateNotificationRequest) {
        return Notification.builder()
                .id(UUID.randomUUID().toString())
                .title(updateNotificationRequest.getTitle())
                .content(updateNotificationRequest.getContent())
                .file(FileUtils.convertMultipartFileArrayToString(updateNotificationRequest.getFile()))
                .createDate(new Date())
                .build();
    }

    public Notification toEntity (UpdateNotificationRequest updateNotificationRequest, String id) {
        return Notification.builder()
                .id(id)
                .title(updateNotificationRequest.getTitle())
                .content(updateNotificationRequest.getContent())
                .file(FileUtils.convertMultipartFileArrayToString(updateNotificationRequest.getFile()))
                .build();
    }

    public List<NotificationResponse> toListResponse(List<Notification> listNoti) {
        return listNoti.stream().map(this::toResponse).collect(Collectors.toList());
    }
}
