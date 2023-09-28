package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.constant.NotificationConstant;
import com.shsoftvina.erpshsoftvina.converter.notification.NotificationConverter;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.mapper.NotificationMapper;
import com.shsoftvina.erpshsoftvina.model.request.notification.NotificationRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationResponse;
import com.shsoftvina.erpshsoftvina.service.NotificationService;
import com.shsoftvina.erpshsoftvina.ultis.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
        return notificationConverter.toResponse(notificationMapper.findById(id));
    }

    @Override
    public void createNoti(NotificationRequest notificationRequest) {

        FileUtils.saveMultipleFilesToServer(request, NotificationConstant.UPLOAD_FILE_DIR,
                notificationRequest.getFile());
        Notification notification = notificationConverter.toEntity(notificationRequest);
        notificationMapper.createNoti(notification);
    }

    @Override
    public boolean updateNoti(NotificationRequest notificationRequest, String id) {
        Notification notification = notificationConverter.toEntity(notificationRequest);
        notification.setId(id);
        return notificationMapper.updateNoti(notification);
    }

    @Override
    public boolean delNoti(String id) {
        return notificationMapper.delNoti(id);
    }
}
