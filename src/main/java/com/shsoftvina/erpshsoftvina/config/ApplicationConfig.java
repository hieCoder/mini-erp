package com.shsoftvina.erpshsoftvina.config;

import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import java.util.Properties;

@Configuration
@PropertySource("classpath:application.properties")
public class ApplicationConfig {

    @Value("${multipart.defaultEncoding}")
    private String defaultEncoding;

    @Value("${multipart.max-file-size}")
    private String maxFileSize;

    @Value("${multipart.max-request-size}")
    private String maxRequestSize;

    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setDefaultEncoding(defaultEncoding);
        multipartResolver.setMaxUploadSize(FileUtils.parseFileSize(maxRequestSize));
        multipartResolver.setMaxUploadSizePerFile(FileUtils.parseFileSize(maxFileSize));
        return multipartResolver;
    }
}
