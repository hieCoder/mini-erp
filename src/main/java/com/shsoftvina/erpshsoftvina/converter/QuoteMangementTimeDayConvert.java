package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.entity.QuoteManagementTimeDay;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.QuoteDto;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.QuoteResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
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
