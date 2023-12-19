package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.entity.YearManagementTimeDay;
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
                .user(User.builder().id(userId).build()).build();
    }

    public YearResponse toResponse(YearManagementTimeDay yearManagementTimeDay){
        return YearResponse.builder()
                .year(yearManagementTimeDay.getCode())
                .target(JsonUtils.jsonToObject(yearManagementTimeDay.getTarget(), String[].class)).build();
    }
}
