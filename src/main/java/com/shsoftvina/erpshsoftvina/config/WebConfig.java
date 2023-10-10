package com.shsoftvina.erpshsoftvina.config;

import com.shsoftvina.erpshsoftvina.security.UpdateProfileFirstInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private UpdateProfileFirstInterceptor updateProfileFirstInterceptor;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/upload/**")
                .addResourceLocations("classpath:/upload/");

        registry
                .addResourceHandler("/assets/**")
                .addResourceLocations("/assets/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry){
        registry.addInterceptor(updateProfileFirstInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/login", "/register", "**/assets/**")
                .order(Ordered.HIGHEST_PRECEDENCE);
    }
}
