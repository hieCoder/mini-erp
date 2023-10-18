package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.ManagementTimeDayDetail;
import com.shsoftvina.erpshsoftvina.entity.Notification;
import com.shsoftvina.erpshsoftvina.enums.managementtime_daydetail.DayDetailCodeEnum;
import com.shsoftvina.erpshsoftvina.mapper.ManagementTimeDayMapper;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.daydetail.DayDetailUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationShowResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class ManagementTimeDayDetailConverter {

    @Autowired
    private ManagementTimeDayMapper managementTimeDayMapper;

    public ManagementTimeDayDetail toEntity(DayDetailCreateRequest dayDetailCreateRequest) {



        String sixToTwelvePM = null;
        String twelveToSixPM = null;
        String sixToTwelveAM = null;

        if (dayDetailCreateRequest.getCode().equals(DayDetailCodeEnum.SIX_TO_TWELVE_PM.toString())) {
            sixToTwelvePM = JsonUtils.objectToJson(dayDetailCreateRequest.getData());
        } else if(dayDetailCreateRequest.getCode().equals(DayDetailCodeEnum.TWELVE_TO_SIX_PM.toString())){
            twelveToSixPM = JsonUtils.objectToJson(dayDetailCreateRequest.getData());
        } else if(dayDetailCreateRequest.getCode().equals(DayDetailCodeEnum.SIX_TO_TWELVE_AM.toString())){
            sixToTwelveAM = JsonUtils.objectToJson(dayDetailCreateRequest.getData());
        }

        return ManagementTimeDayDetail.builder()
                .id(UUID.randomUUID().toString())
                .managementTimeDay(managementTimeDayMapper.findById(dayDetailCreateRequest.getDayId()))
                .sixToTwelvePM(sixToTwelvePM)
                .twelveToSixPM(twelveToSixPM)
                .sixToTwelveAM(sixToTwelveAM)
                .build();
    }

    public ManagementTimeDayDetail toUpdateEntity(DayDetailUpdateRequest dayDetailUpdateRequest) {

        String sixToTwelvePM = null;
        String twelveToSixPM = null;
        String sixToTwelveAM = null;

        if (dayDetailUpdateRequest.getCode().equals(DayDetailCodeEnum.SIX_TO_TWELVE_PM.toString())) {
            sixToTwelvePM = JsonUtils.objectToJson(dayDetailUpdateRequest.getData());
        } else if(dayDetailUpdateRequest.getCode().equals(DayDetailCodeEnum.TWELVE_TO_SIX_PM.toString())){
            twelveToSixPM = JsonUtils.objectToJson(dayDetailUpdateRequest.getData());
        } else if(dayDetailUpdateRequest.getCode().equals(DayDetailCodeEnum.SIX_TO_TWELVE_AM.toString())){
            sixToTwelveAM = JsonUtils.objectToJson(dayDetailUpdateRequest.getData());
        }

        return ManagementTimeDayDetail.builder()
                .id(dayDetailUpdateRequest.getId())
                .sixToTwelvePM(sixToTwelvePM)
                .twelveToSixPM(twelveToSixPM)
                .sixToTwelveAM(sixToTwelveAM)
                .build();
    }

}
