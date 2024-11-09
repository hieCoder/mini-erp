package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.Notification;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.enums.Notification.StatusNotificationEnum;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.request.notification.CreateNotificationRequest;
import com.hieDev.minierp.model.request.notification.UpdateNotificationRequest;
import com.hieDev.minierp.model.response.notification.NotificationDetailResponse;
import com.hieDev.minierp.model.response.notification.NotificationShowResponse;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.DateUtils;
import com.hieDev.minierp.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
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

