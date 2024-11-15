package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.constant.NotificationConstant;
import com.hieDev.minierp.constant.SettingConstant;
import com.hieDev.minierp.converter.NotificationConverter;
import com.hieDev.minierp.exception.FileTooLimitedException;
import com.hieDev.minierp.exception.NotFoundException;
import com.hieDev.minierp.entity.Notification;
import com.hieDev.minierp.entity.Setting;
import com.hieDev.minierp.enums.Notification.StatusNotificationEnum;
import com.hieDev.minierp.mapper.NotificationMapper;
import com.hieDev.minierp.mapper.SettingMapper;
import com.hieDev.minierp.model.request.notification.CreateNotificationRequest;
import com.hieDev.minierp.model.request.notification.UpdateNotificationRequest;
import com.hieDev.minierp.model.response.notification.NotificationDetailResponse;
import com.hieDev.minierp.model.response.notification.NotificationShowResponse;
import com.hieDev.minierp.service.NotificationService;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.FileUtils;
import com.hieDev.minierp.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class NotificationImpl implements NotificationService {

    @Autowired
    private NotificationMapper notificationMapper;

    @Autowired
    private NotificationConverter notificationConverter;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Autowired
    private SettingMapper settingMapper;

    @Override
    public List<NotificationShowResponse> getAllNoti(int start, int pageSize, String search) {
        StatusNotificationEnum status = StatusNotificationEnum.ACTIVE;
        if (!search.isEmpty()) start = 0;
        List<Notification> notificationList = notificationMapper.getAllNoti(start, pageSize, search, status);
        return notificationConverter.toListShowResponse(notificationList);
    }

    @Override
    public List<NotificationShowResponse> getInactiveNoti(int start, int pageSize) {
        StatusNotificationEnum status = StatusNotificationEnum.INACTIVE;
        List<Notification> notificationList = notificationMapper.getInactiveNoti(start, pageSize, status);
        return notificationConverter.toListShowResponse(notificationList);
    }

    @Override
    public NotificationDetailResponse createNoti(CreateNotificationRequest createNotificationRequest) {

        MultipartFile[] files = createNotificationRequest.getFiles();

        String dir = NotificationConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = null;

        if (files!= null){
            applicationUtils.checkValidateFile(Notification.class, files);

            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(dir, files);
        } else{
            listFileNameSaveFileSuccess = new ArrayList<>();
        }

        if(listFileNameSaveFileSuccess != null){
            Notification notification = notificationConverter.toEntity(createNotificationRequest, listFileNameSaveFileSuccess);
            try{
                notificationMapper.createNoti(notification);
                return notificationConverter.toNotificationDetailResponse(notification);
            } catch (Exception e){
                FileUtils.deleteMultipleFilesToServer(dir, notification.getFiles());
                return null;
            }
        }
        return null;
    }

    @Override
    public NotificationDetailResponse updateNotification(UpdateNotificationRequest updateNotificationRequest, String id){
        Notification notificationDb = notificationMapper.getNotificationById(id);
        if(notificationDb == null){
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));
        }
        String dir = NotificationConstant.UPLOAD_FILE_DIR;
        String fileList = notificationDb.getFiles();
        if(fileList == null){
            fileList="";
        }
        List<String> files = Arrays.asList(fileList.split(","));
        List<String> oldFile = Arrays.asList(updateNotificationRequest.getOldFile());
        List<String> removeFiles = new ArrayList<>();
        List<String> newFiles    = new ArrayList<>();
        for (String file : files) {
            if (!oldFile.contains(file)) {
                removeFiles.add(file);
            }else{
                newFiles.add(file);
            }
        }
        MultipartFile[] upFiles = updateNotificationRequest.getFiles();
        List<String> newFilesUpdate = new ArrayList<>();
        if (upFiles!= null){

            applicationUtils.checkValidateFile(Notification.class, upFiles);

            Setting setting = settingMapper.findByCode(SettingConstant.NOTIFICATION_CODE);
            if((upFiles.length + oldFile.size()) > setting.getFileLimit()) {
                throw new FileTooLimitedException(MessageErrorUtils.notAllowFileLimit(setting.getFileLimit()));
            }

            newFilesUpdate = FileUtils.saveMultipleFilesToServer(dir, upFiles);
            newFiles.addAll(newFilesUpdate);
        }
        List<String> listFileNameSaveFileSuccess = newFiles;
        Notification notificationUpdate =  notificationConverter.toEntity(updateNotificationRequest, id, listFileNameSaveFileSuccess);
        int rs = notificationMapper.updateNotification(notificationUpdate);
        if(rs > 0){
            NotificationDetailResponse updateNotification = notificationConverter.toNotificationDetailResponse(notificationMapper.getNotificationById(id));
            FileUtils.deleteMultipleFilesToServer(dir, String.join(",", removeFiles));
            return (updateNotification);
        } else{
            FileUtils.deleteMultipleFilesToServer(dir, String.join(",", newFilesUpdate));
            throw new NotFoundException("Fail to update notification");
        }
    }

    @Override
    public boolean delNoti(String id) {
        Notification notification = notificationMapper.findById(id);
        if(notification == null){
            throw new NotFoundException(MessageErrorUtils.notFound("Id"));
        }
        try {
            notificationMapper.delNoti(id, StatusNotificationEnum.INACTIVE);
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
        return notificationMapper.countAll(search, StatusNotificationEnum.ACTIVE);
    }

    @Override
    public List<NotificationShowResponse> getNotificationLatest(int limit) {
        List<Notification> notificationList = notificationMapper.getNotificationLatest(limit);
        return notificationConverter.toListShowResponse(notificationList);
    }
}