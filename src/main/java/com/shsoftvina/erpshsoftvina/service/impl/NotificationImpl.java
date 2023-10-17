package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.constant.NotificationConstant;
import com.shsoftvina.erpshsoftvina.constant.SettingConstant;
import com.shsoftvina.erpshsoftvina.converter.NotificationConverter;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.entity.Setting;
import com.shsoftvina.erpshsoftvina.exception.FileTooLimitedException;
import com.shsoftvina.erpshsoftvina.exception.FileTypeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.NotificationMapper;
import com.shsoftvina.erpshsoftvina.mapper.SettingMapper;
import com.shsoftvina.erpshsoftvina.model.request.notification.CreateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest;
import com.shsoftvina.erpshsoftvina.model.request.notification.UpdateNotificationRequest2;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationShowResponse;
import com.shsoftvina.erpshsoftvina.service.NotificationService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import liquibase.pro.packaged.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
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
    private HttpServletRequest request;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Autowired
    private SettingMapper settingMapper;

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
            applicationUtils.checkValidateFile(Notification.class, files);

            listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, files);
        } else{
            listFileNameSaveFileSuccess = new ArrayList<>();
        }

        if(listFileNameSaveFileSuccess != null){
            Notification notification = notificationConverter.toEntity(createNotificationRequest, listFileNameSaveFileSuccess);
            try{
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
            applicationUtils.checkValidateFile(Notification.class, files);

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
    public NotificationDetailResponse updateNotification(UpdateNotificationRequest2 updateNotificationRequest2, String id){
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
        List<String> oldFile = Arrays.asList(updateNotificationRequest2.getOldFile());
        List<String> removeFiles = new ArrayList<>();
        List<String> newFiles    = new ArrayList<>();
        for (String file : files) {
            if (!oldFile.contains(file)) {
                removeFiles.add(file);
            }else{
                newFiles.add(file);
            }
        }
        MultipartFile[] upFiles = updateNotificationRequest2.getFiles();
        List<String> newFilesUpdate = new ArrayList<>();
        if (upFiles!= null){

            Setting setting = settingMapper.findByCode(SettingConstant.NOTIFICAITON_CODE);

            if((upFiles.length + oldFile.size()) > setting.getFileSize()) {
                throw new FileTooLimitedException(MessageErrorUtils.notAllowFileSize());
            }
            if(!FileUtils.isAllowedFileType(upFiles, setting.getFileType())){
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType(setting.getFileType()));
            }
            newFilesUpdate = FileUtils.saveMultipleFilesToServer(request, dir, upFiles);
            newFiles.addAll(newFilesUpdate);
        }
        List<String> listFileNameSaveFileSuccess = newFiles;
        Notification notificationUpdate =  notificationConverter.toEntity2(updateNotificationRequest2, id, listFileNameSaveFileSuccess);
        int rs = notificationMapper.updateNotification(notificationUpdate);
        if(rs > 0){
            NotificationDetailResponse updateNotification = notificationConverter.toNotificationDetailResponse(notificationMapper.getNotificationById(id));
            FileUtils.deleteMultipleFilesToServer(request, dir, String.join(",", removeFiles));
            return (updateNotification);
        } else{
            FileUtils.deleteMultipleFilesToServer(request, dir, String.join(",", newFilesUpdate));
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
    public NotificationShowResponse getNotification(String id){
        return notificationConverter.toShowResponse(notificationMapper.getNotificationById(id));
    }

    @Override
    public int countAll(String search){
        return notificationMapper.countAll(search);
    };
}