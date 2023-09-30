package com.shsoftvina.erpshsoftvina.utils;

public class EnumUtils {
    public static <T extends Enum<T>> boolean isExistInEnum(Class<T> enumClass, String value) {
        try {
            Enum.valueOf(enumClass, value);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }
}
