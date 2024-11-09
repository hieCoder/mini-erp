package com.hieDev.minierp.utils;

public class StringUtils {

    public static boolean isBlank(String s){
        if(s == null || s.isEmpty()) return true;
        return false;
    }

    public static String[] split(String s, String regex){
        if (!isBlank(s)) {
            return s.split(regex);
        }
        return null;
    }

    public static String getDifference(String old, String newStr) {

        if(isBlank(newStr)) return old;

        if(isBlank(old)) return null;

        String[] oldArray = old.split(",");
        String[] newArray = newStr.split(",");

        StringBuilder result = new StringBuilder();

        for (String element : oldArray) {
            if (!containsElement(newArray, element)) {
                if (result.length() > 0) {
                    result.append(",");
                }
                result.append(element);
            }
        }

        return result.toString();
    }

    private static boolean containsElement(String[] array, String element) {
        for (String e : array) {
            if (e.equals(element)) {
                return true;
            }
        }
        return false;
    }
}
