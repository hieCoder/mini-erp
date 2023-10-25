package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.Notification.StatusNotificationEnum;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationShowResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class NotificationConverter {
    @Autowired
    CommentNotificationConverter commentNotificationConverter;
    @Autowired
    UserMapper userMapper;

    public NotificationShowResponse toShowResponse(Notification notification) {
        return NotificationShowResponse.builder()
                .id(notification.getId())
                .user(notification.getUser())
                .title(notification.getTitle())
                .content(notification.getContent())
                .files(FileUtils.getPathUploadList(Notification.class, notification.getFiles()))
                .createdDate(DateUtils.formatDateTime(notification.getCreatedDate()))
                .build();
    }

    public List<NotificationShowResponse> toListShowResponse(List<Notification> notifications) {
        return notifications.stream().map(this::toShowResponse).collect(Collectors.toList());
    }


    public Notification toEntity(CreateNotificationRequest createNotificationRequest, List<String> listFileNameSaveFileSuccess) {

        String files = null;
        if(!listFileNameSaveFileSuccess.isEmpty()){
            files = String.join(",", listFileNameSaveFileSuccess);
        }

        return Notification.builder()
                .user(userMapper.findById(createNotificationRequest.getUserId()))
                .id(ApplicationUtils.generateId())
                .title(createNotificationRequest.getTitle())
                .content(createNotificationRequest.getContent())
                .files(files)
                .createdDate(new Date())
                .status(StatusNotificationEnum.ACTIVE)
                .build();
    }

    public Notification toEntity(UpdateNotificationRequest updateNotificationRequest, String id, List<String> listFileNameSaveFileSuccess) {
        return Notification.builder()
                .id(id)
                .createdDate(new Date())
                .title(updateNotificationRequest.getTitle())
                .content(updateNotificationRequest.getContent())
                .files(String.join(",", listFileNameSaveFileSuccess))
                .build();
    }

    public NotificationDetailResponse toNotificationDetailResponse(Notification notification) {
        User user = notification.getUser();
        String fullnameUser = null;
        if(user != null){
            fullnameUser = user.getFullname();
        }
        return NotificationDetailResponse.builder()
                .id(notification.getId())
                .status(notification.getStatus())
                .title(notification.getTitle())
                .content(notification.getContent())
                .fullnameUser(fullnameUser)
                .idUser(notification.getUser().getId())
                .files(FileUtils.getPathUploadList(Notification.class, notification.getFiles()))
                .createdDate(DateUtils.formatDateTime(notification.getCreatedDate()))
                .comments(commentNotificationConverter.toListResponse(notification.getComments()))
                .build();
    }
}

