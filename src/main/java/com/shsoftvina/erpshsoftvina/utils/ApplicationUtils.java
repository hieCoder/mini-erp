package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.enums.task.ActionChangeStatusTaskEnum;
import com.shsoftvina.erpshsoftvina.enums.task.StatusTaskEnum;
import com.shsoftvina.erpshsoftvina.model.dto.ActionChangeStatusTaskEnumDto;
import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;

public class ApplicationUtils {

//    public static List<StatusTaskEnum> listNextStage(StatusTaskEnum status){
//
////        switch (status){
////            case REGISTERED:
////        }
//        return null;
//    }

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
}
