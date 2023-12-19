package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.QuoteManagementTimeDay;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QuoteManagementTimeDayMapper {
    int createQuote(QuoteManagementTimeDay quoteManagementTimeDay);
    int editQuote(QuoteManagementTimeDay quoteManagementTimeDay);
    QuoteManagementTimeDay findByUserId(String userId);
}
