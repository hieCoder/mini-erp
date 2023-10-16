package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.constant.NotificationConstant;
import com.shsoftvina.erpshsoftvina.converter.NotificationConverter;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.exception.FileTooLimitedException;
import com.shsoftvina.erpshsoftvina.exception.FileTypeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.NotificationMapper;
import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationShowResponse;
import com.shsoftvina.erpshsoftvina.service.NotificationService;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import liquibase.pro.packaged.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
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
    public List<NotificationShowResponse> getAllNoti(int start, int pageSize, String search) {
        List<Notification> notificationList = notificationMapper.getAllNoti(start, pageSize, search);
        return notificationConverter.toListShowResponse(notificationList);
    }

    @Override
    public int createNoti(CreateNotificationRequest createNotificationRequest) {

        MultipartFile[] files = createNotificationRequest.getFiles();

        String dir = NotificationConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = null;

        if (files!= null){
            if(files.length > ApplicationConstant.NUMBER_UPLOAD_FILE_LIMIT) {
                throw new FileTooLimitedException(MessageErrorUtils.notAllowFileSize());
            }
            if(!FileUtils.isAllowedFileType(files, ApplicationConstant.LIST_TYPE_FILE)){
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType());
            }

            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, files);
        } else{
            listFileNameSaveFileSuccess = new ArrayList<>();
        }

        if(listFileNameSaveFileSuccess != null){
            Notification notification = notificationConverter.toEntity(createNotificationRequest, listFileNameSaveFileSuccess);
            try{
                System.out.println(notification);
                notificationMapper.createNoti(notification);
                return 1;
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request,dir, notification.getFiles());
                return 0;
            }
        }
        return 0;
    }

    @Override
    public int updateNoti(UpdateNotificationRequest updateNotificationRequest, String id) {

        MultipartFile[] files = updateNotificationRequest.getFile();

        String dir = NotificationConstant.UPLOAD_FILE_DIR;

        String listFileNameOld = null;
        List<String> listFileNameSaveFileSuccess = null;

        Notification notification = notificationMapper.findById(id);
        if (files!= null){
            if(files.length > ApplicationConstant.NUMBER_UPLOAD_FILE_LIMIT) {
                throw new FileTooLimitedException(MessageErrorUtils.notAllowFileSize());
            }
            if(!FileUtils.isAllowedFileType(files, ApplicationConstant.LIST_TYPE_FILE)){
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType());
            }
            if(notification == null){
                throw new NotFoundException(MessageErrorUtils.notFound("Id"));
            }

            listFileNameOld = notification.getFiles();
            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, files);

        } else{
            listFileNameSaveFileSuccess = new ArrayList<>();
        }

        if(listFileNameSaveFileSuccess != null){
            try{
                notification = notificationConverter.toEntity(updateNotificationRequest, id, listFileNameSaveFileSuccess);
                notificationMapper.updateNoti(notification);
                FileUtils.deleteMultipleFilesToServer(request, dir, listFileNameOld);
                return 1;
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(request, dir, String.join(",", listFileNameSaveFileSuccess));
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
            FileUtils.deleteMultipleFilesToServer(request, dir, notification.getFiles());
            return true;
        } catch (Exception e){
        }
        return false;
    }

    @Override
    public NotificationDetailResponse findById(String id){
        return notificationConverter.toNotificationDetailResponse(notificationMapper.findById(id));
    }

    @Override
    public int countAll(String search){
        return notificationMapper.countAll(search);
    };
}