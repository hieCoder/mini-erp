package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.entity.YearManagementTimeDay;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.YearTargetDto;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.YearRequest;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.YearResponse;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.stereotype.Component;

@Component
public class YearManagementTimeDayConverter {

    public YearManagementTimeDay toEntity(String userId, YearRequest yearRequest){
        return YearManagementTimeDay.builder()
                .code(yearRequest.getYear())
                .target(JsonUtils.objectToJson(yearRequest.getTarget()))
                .selfInspiration(yearRequest.getSelfInspiration())
                .color(JsonUtils.objectToJson(yearRequest.getColor()))
                .user(User.builder().id(userId).build()).build();
    }

    public YearResponse toResponse(YearManagementTimeDay yearManagementTimeDay){
        if (yearManagementTimeDay == null) return null;
        return YearResponse.builder()
                .year(yearManagementTimeDay.getCode())
                .target(JsonUtils.jsonToObject(yearManagementTimeDay.getTarget(), YearTargetDto[].class))
                .selfInspiration(yearManagementTimeDay.getSelfInspiration())
                .color(JsonUtils.jsonToObject(yearManagementTimeDay.getColor(), String[].class))
                .build();
    }
}
