package com.hieDev.minierp.utils;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

public class ValidateUtils {
    public static Map<String, String> validate(Object obj) throws IllegalAccessException {
        Map<String, String> errors = new HashMap<>();
        Class<?> clazz = obj.getClass();
        Field[] fields = clazz.getDeclaredFields();

        for (Field field : fields) {
            field.setAccessible(true);

            if(field.getType().equals(Long.class)) {
                if (field.get(obj) == null) {
                    errors.put(field.getName(),"Field is not filled");
                }
            }

            if(field.getType().equals(String.class) && !field.getName().equals("note")) {
                String value = (String) field.get(obj);
                if (value == null || value.trim().isEmpty()) {
                    errors.put(field.getName(),"Field is not filled");
                }
            }
        }

        return errors;
    }
}
