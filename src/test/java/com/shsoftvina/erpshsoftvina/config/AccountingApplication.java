package com.shsoftvina.erpshsoftvina.config;

import com.shsoftvina.erpshsoftvina.service.AccountingService;
import com.shsoftvina.erpshsoftvina.service.impl.AccountingServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AccountingApplication {
    @Bean
    public AccountingService accountingService() {
        return new AccountingServiceImpl();
    }
}
