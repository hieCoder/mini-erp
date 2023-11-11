package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.constant.CacheConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Component;

@Component
public class CacheUtils {

    @Autowired
    private CacheManager cacheManager;

    public String createVerificationToken(String content) {
        String token = ApplicationUtils.generateVerifyMailCode();
        cacheManager.getCache(CacheConstant.CACHE_NAME).put(token, content);
        return token;
    }

    public String getVerificationToken(String token) {
        Cache.ValueWrapper valueWrapper = cacheManager.getCache(CacheConstant.CACHE_NAME).get(token);
        return (valueWrapper != null) ? (String) valueWrapper.get() : null;
    }

    public void deleteVerificationToken(String token) {
        cacheManager.getCache(CacheConstant.CACHE_NAME).evict(token);
    }
}
