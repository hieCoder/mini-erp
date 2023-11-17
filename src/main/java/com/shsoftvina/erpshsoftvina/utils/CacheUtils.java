package com.shsoftvina.erpshsoftvina.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

@Component
public class CacheUtils {

    @Value("${cache.name}")
    private String cacheName;

    @CachePut(value = "#{@cacheUtils.cacheName}", key = "#token")
    public String createVerificationToken(String token, String content) {
        return content;
    }

    @Cacheable(value = "#{@cacheUtils.cacheName}", key = "#token")
    public String getVerificationToken(String token) {
        return null;
    }

    @CacheEvict(value = "#{@cacheUtils.cacheName}", key = "#token")
    public void deleteVerificationToken(String token) {
    }
}
