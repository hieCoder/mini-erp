package com.shsoftvina.erpshsoftvina.config;


import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {



    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/upload/**")
                .addResourceLocations("classpath:/upload/");

        registry
                .addResourceHandler("/assets/**")
                .addResourceLocations("/assets/");
        registry
                .addResourceHandler("/upload/**")
                .addResourceLocations("/upload/");

    }
}
