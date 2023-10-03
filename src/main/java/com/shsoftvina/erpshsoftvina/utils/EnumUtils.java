package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;

import java.lang.reflect.Field;

public class EnumUtils {
    public static <T extends Enum<T>> boolean isExistInEnum(Class<T> enumClass, String value) {
        try {
            Enum.valueOf(enumClass, value);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    public static EnumDto instance(Enum<?> enumValue) {
        if(enumValue != null){
            EnumDto enumDto = new EnumDto();
            enumDto.setCode(enumValue.name());
            try {
                Field field = enumValue.getClass().getDeclaredField("value");
                field.setAccessible(true);
                enumDto.setName((String) field.get(enumValue));
            } catch (NoSuchFieldException | IllegalAccessException e) {
            }
            return enumDto;
        }
        return null;
    }
}