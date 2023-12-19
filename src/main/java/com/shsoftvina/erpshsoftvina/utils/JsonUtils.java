package com.shsoftvina.erpshsoftvina.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shsoftvina.erpshsoftvina.exception.ErrorConvertJsonException;

public class JsonUtils {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static <T> T jsonToObject(String json, Class<T> valueType) {

        if(StringUtils.isBlank(json)){
            return null;
        }

        try {
            return objectMapper.readValue(json, valueType);
        } catch (Exception e) {
            throw new ErrorConvertJsonException("Error convert json to object");
        }
    }

    public static String objectToJson(Object object) {
        try {
            if(object == null) return null;
            return objectMapper.writeValueAsString(object);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
