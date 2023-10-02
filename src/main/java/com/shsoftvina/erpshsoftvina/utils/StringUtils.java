package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.constant.AccountingConstant;
import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.User;

public class StringUtils {

    public static boolean isEmpty(String s){
        if(s == null || s.isEmpty()) return true;
        return false;
    }

    public static String[] split(String s, String regex){
        if (!isEmpty(s)) {
            return s.split(regex);
        }
        return null;
    }

    public static String[] splitPathFile(Class<?> entityClass, String s, String regex){
        if (!isEmpty(s)) {
            String[] parts = s.split(regex);
            for (int i = 0; i < parts.length; i++) {
                String pathRoot = "";
                if(entityClass == User.class){
                    pathRoot = UserConstant.PATH_FILE;
                } else if(entityClass == Accounting.class){
                    pathRoot = AccountingConstant.PATH_FILE;
                }
                parts[i] = pathRoot + parts[i];
            }
            return parts;
        }
        return null;
    }
}
