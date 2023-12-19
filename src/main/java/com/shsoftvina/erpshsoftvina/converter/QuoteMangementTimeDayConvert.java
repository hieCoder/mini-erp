package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.QuoteManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.QuoteResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.stereotype.Component;

@Component
public class QuoteMangementTimeDayConvert {

    public QuoteManagementTimeDay toEntity(String userId, String[] quotes) {
        return QuoteManagementTimeDay.builder()
                .id(ApplicationUtils.generateId())
                .content(JsonUtils.objectToJson(quotes))
                .user(User.builder().id(userId).build())
                .build();
    }

    public QuoteResponse toResponse(QuoteManagementTimeDay quoteManagementTimeDay) {
        if(quoteManagementTimeDay == null) return null;
        return QuoteResponse.builder()
                .id(quoteManagementTimeDay.getId())
                .content(JsonUtils.jsonToObject(quoteManagementTimeDay.getContent(), String[].class))
                .build();
    }

}
