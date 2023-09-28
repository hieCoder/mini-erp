package com.shsoftvina.erpshsoftvina.converter.notification;

import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.model.request.notification.NotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationResponse;
import com.shsoftvina.erpshsoftvina.ultis.DataFormatUtils;
import com.shsoftvina.erpshsoftvina.ultis.FileUtils;
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
                .file(notification.getFile())
                .createDate(DataFormatUtils.formatDateTime(notification.getCreateDate()))
                .build();
    }

    public Notification toEntity (NotificationRequest notificationRequest) {
        return Notification.builder()
                .id(UUID.randomUUID().toString())
                .title(notificationRequest.getTitle())
                .content(notificationRequest.getContent())
                .file(FileUtils.convertMultipartFileArrayToString(notificationRequest.getFile()))
                .createDate(new Date())
                .build();
    }

    public List<NotificationResponse> toListResponse(List<Notification> listNoti) {
        return listNoti.stream().map(this::toResponse).collect(Collectors.toList());
    }
}
