package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.constant.NotificationConstant;
import com.shsoftvina.erpshsoftvina.converter.NotificationConverter;

import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.exception.FileTooLimitedException;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.NotificationMapper;
import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationCommentsListResponse;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationResponse;
import com.shsoftvina.erpshsoftvina.service.NotificationService;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class NotificationImpl implements NotificationService {

    @Autowired
    NotificationMapper notificationMapper;

    @Autowired
    NotificationConverter notificationConverter;

    @Autowired
    private HttpServletRequest request;

    @Override
    public List<NotificationResponse> getAllNoti(int start, int pageSize) {
        List<Notification> notificationList = notificationMapper.getAllNoti(start, pageSize);
        return notificationConverter.toListResponse(notificationList);
    }

    @Override
    public NotificationResponse findById(String id) {
        Notification notification = notificationMapper.findById(id);
        return notificationConverter.toResponse(notification);
    }

    @Override
    public int createNoti(CreateNotificationRequest createNotificationRequest) {

        if (createNotificationRequest.getFile().length > ApplicationConstant.NUMBER_UPLOAD_FILE_LIMIT) {
            throw new FileTooLimitedException(MessageErrorUtils.notAllowFileSize());
        }

        String dir = NotificationConstant.UPLOAD_FILE_DIR;

        List<String> listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, createNotificationRequest.getFile());
        if(listFileNameSaveFileSuccess != null){
            Notification notification = notificationConverter.toEntity(createNotificationRequest, listFileNameSaveFileSuccess);
            try{
                notificationMapper.createNoti(notification);
                return 1;
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request,dir, notification.getFile());
                return 0;
            }
        }
        return 0;
    }

    @Override
    public int updateNoti(UpdateNotificationRequest updateNotificationRequest, String id) {

        if (updateNotificationRequest.getFile().length > ApplicationConstant.NUMBER_UPLOAD_FILE_LIMIT) {
            throw new FileTooLimitedException(MessageErrorUtils.notAllowFileSize());
        }

        Notification notification = notificationMapper.findById(id);

        if(notification == null){
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));
        }

        String listFileNameOld = notification.getFile();

        String dir = NotificationConstant.UPLOAD_FILE_DIR;

        List<String> listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, updateNotificationRequest.getFile());

        if(listFileNameSaveFileSuccess != null){
            try{
                notification = notificationConverter.toEntity(updateNotificationRequest, id, listFileNameSaveFileSuccess);
                notificationMapper.updateNoti(notification);
                return 1;
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request, dir, listFileNameOld);
                return 0;
            }
        }
        return 0;
    }

    @Override
    public boolean delNoti(String id) {
        Notification notification = notificationMapper.findById(id);
        if(notification == null){
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));
        }
        try {
            notificationMapper.delNoti(id);
            String dir = NotificationConstant.UPLOAD_FILE_DIR;
            FileUtils.deleteMultipleFilesToServer(request, dir, notification.getFile());
            return true;
        } catch (Exception e){
        }
        return false;
    }

    @Override
    public NotificationCommentsListResponse getCommentsByNotificationId(String notificationId){
        Notification comments = notificationMapper.getCommentsByNotificationId(notificationId);
        System.out.println(comments);
        return notificationConverter.toListCommentsResponse(comments);
    }
}
