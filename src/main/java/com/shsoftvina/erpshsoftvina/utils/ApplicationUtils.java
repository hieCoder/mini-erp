package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.constant.SettingConstant;
import com.shsoftvina.erpshsoftvina.entity.*;
import com.shsoftvina.erpshsoftvina.enums.task.ActionChangeStatusTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusTaskEnum;
import com.shsoftvina.erpshsoftvina.exception.FileLimitNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.FileSizeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.FileTypeNotAllowException;
import com.shsoftvina.erpshsoftvina.mapper.SettingMapper;
import com.shsoftvina.erpshsoftvina.model.dto.task.ActionChangeStatusTaskEnumDto;
import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import com.shsoftvina.erpshsoftvina.security.Principal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class ApplicationUtils {

    @Autowired
    private SettingMapper settingMapper;

    public static ActionChangeStatusTaskEnumDto instance(StatusTaskEnum statusTaskEnum) {
        if(statusTaskEnum != null){
            ActionChangeStatusTaskEnumDto dto = new ActionChangeStatusTaskEnumDto();
            dto.setCode(statusTaskEnum.name());
            dto.setName(statusTaskEnum.getValue());

            ActionChangeStatusTaskEnum[] actionEnums = statusTaskEnum.getActions();
            EnumDto[] actionDtos = new EnumDto[actionEnums.length];
            for (int i = 0; i < actionEnums.length; i++) {
                actionDtos[i] = EnumUtils.instance(actionEnums[i]);
            }
            dto.setActions(actionDtos);
            return dto;
        }
        return null;
    }

    public static StatusTaskEnum getNextStatusTaskEnum(StatusTaskEnum statusCurrent, String action){

        StatusTaskEnum nextStatusTask= null;

        if(StringUtils.isBlank(action)) return statusCurrent;

        switch (statusCurrent){
            case REGISTERED:
                if(action.equals(ActionChangeStatusTaskEnum.OPEN.toString())) nextStatusTask = StatusTaskEnum.OPENED;
                break;
            case OPENED:
            case REOPENED:
                if(action.equals(ActionChangeStatusTaskEnum.CLOSE.toString())) nextStatusTask = StatusTaskEnum.CLOSED;
                else if (action.equals(ActionChangeStatusTaskEnum.POSTPONE.toString())) nextStatusTask = StatusTaskEnum.POSTPONED;
                break;
            case POSTPONED:
            case CLOSED:
                if(action.equals(ActionChangeStatusTaskEnum.REOPEN.toString())) nextStatusTask = StatusTaskEnum.REOPENED;
                break;
        }
        return nextStatusTask;
    }

    public static boolean isActionValidForUpdateStatusTask(StatusTaskEnum statusCurrent, String action){

        ActionChangeStatusTaskEnum actionEnum = EnumUtils.getEnumFromValue(ActionChangeStatusTaskEnum.class, action);

        if(actionEnum == null) return true;

        ActionChangeStatusTaskEnum[] actionAllows = statusCurrent.getActions();
        for(ActionChangeStatusTaskEnum actionAllow: actionAllows){
            if(actionAllow.equals(actionEnum)) {
                return true;
            }
        }
        return false;
    }

    private Setting getSetting(Class<?> c){
        Setting setting = null;
        if(c == User.class){
            setting = settingMapper.findByCode(SettingConstant.USER_CODE);
        } else if(c == Contract.class){
            setting = settingMapper.findByCode(SettingConstant.CONTRACT_CODE);
        } else if(c == Accounting.class){
            setting = settingMapper.findByCode(SettingConstant.ACCOUNTING_CODE);
        } else if(c == Notification.class){
            setting = settingMapper.findByCode(SettingConstant.NOTIFICAITON_CODE);
        } else if(c == CommentNotification.class){
            setting = settingMapper.findByCode(SettingConstant.NOTIFICAITON_COMMENT_CODE);
        } else if(c == Task.class){
            setting = settingMapper.findByCode(SettingConstant.TASK_CODE);
        } else if(c == CommentTask.class){
            setting = settingMapper.findByCode(SettingConstant.TASK_COMMENT_CODE);
        }
        return setting;
    }

    public void checkValidateImage(Class<?> c, MultipartFile file){

        Setting setting = getSetting(c);

        String imageTypes = setting.getImageType();
        int fileLimit = setting.getFileSize();

        if (!FileUtils.isAllowedFileSize(file))
            throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize());

        if (fileLimit < 1)
            throw new FileLimitNotAllowException(MessageErrorUtils.notAllowFileLimit(fileLimit));

        if (!FileUtils.isAllowedFileType(file, imageTypes))
            throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType(imageTypes));
    }

    public void checkValidateFile(Class<?> c, MultipartFile file){

        Setting setting = getSetting(c);

        String fileTypes = setting.getFileType();
        int fileLimit = setting.getFileSize();

        if (!FileUtils.isAllowedFileSize(file))
            throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize());

        if (fileLimit < 1)
            throw new FileLimitNotAllowException(MessageErrorUtils.notAllowFileLimit(fileLimit));

        if (!FileUtils.isAllowedFileType(file, fileTypes))
            throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType(fileTypes));
    }

    public void checkValidateFile(Class<?> c, MultipartFile[] files){

        Setting setting = getSetting(c);

        int fileLimit = setting.getFileSize();

        if(fileLimit<files.length)
            throw new FileLimitNotAllowException(MessageErrorUtils.notAllowFileLimit(fileLimit));

        for(MultipartFile file: files){
            checkValidateFile(c, file);
        }
    }

    public void checkUserCurrentAllow(String id){


    }
}