package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.enums.task.ActionChangeStatusTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusTaskEnum;
import com.shsoftvina.erpshsoftvina.model.dto.ActionChangeStatusTaskEnumDto;
import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;

public class ApplicationUtils {

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

        if(action == null) return statusCurrent;

        switch (statusCurrent){
            case REGISTERED:
                if(action.equals(ActionChangeStatusTaskEnum.OPEN.toString())) nextStatusTask = StatusTaskEnum.OPENED;
                break;
            case OPENED:
            case REOPENED:
                if(action.equals(ActionChangeStatusTaskEnum.CLOSE.toString())) nextStatusTask = StatusTaskEnum.CLOSED;
                else if (action.equals(ActionChangeStatusTaskEnum.POSTPONE.toString())) nextStatusTask = StatusTaskEnum.POSTPONSED;
                break;
            case POSTPONSED:
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
}