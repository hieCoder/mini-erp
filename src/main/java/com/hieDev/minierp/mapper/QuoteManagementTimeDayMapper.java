package com.hieDev.minierp.mapper;

import com.hieDev.minierp.entity.QuoteManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QuoteManagementTimeDayMapper {
    int createQuote(QuoteManagementTimeDay quoteManagementTimeDay);
    int editQuote(QuoteManagementTimeDay quoteManagementTimeDay);
    QuoteManagementTimeDay findByUserId(String userId);
}
