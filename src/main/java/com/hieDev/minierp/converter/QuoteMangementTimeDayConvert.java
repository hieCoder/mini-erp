package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.QuoteManagementTimeDay;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.model.response.managementtime.day.QuoteResponse;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.FileUtils;
import com.hieDev.minierp.utils.JsonUtils;
import org.springframework.stereotype.Component;

@Component
public class QuoteMangementTimeDayConvert {

    public QuoteManagementTimeDay toEntity(String userId, String[] quotes, String imgQuote) {
        return QuoteManagementTimeDay.builder()
                .id(ApplicationUtils.generateId())
                .content(JsonUtils.objectToJson(quotes))
                .user(User.builder().id(userId).build())
                .image(imgQuote)
                .build();
    }

    public QuoteResponse toResponse(QuoteManagementTimeDay quoteManagementTimeDay) {
        if(quoteManagementTimeDay == null) return null;
        return QuoteResponse.builder()
                .id(quoteManagementTimeDay.getId())
                .content(JsonUtils.jsonToObject(quoteManagementTimeDay.getContent(), String[].class))
                .image(FileUtils.getPathUpload(QuoteManagementTimeDay.class, quoteManagementTimeDay.getImage()))
                .build();
    }

}
