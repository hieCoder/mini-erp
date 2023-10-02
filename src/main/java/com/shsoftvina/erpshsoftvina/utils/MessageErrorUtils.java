package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;

public class MessageErrorUtils {
    public static String notFound(String s){
        return s.concat(" is not found");
    }

    public static String alreadyExists(String s){
        return s.concat(" already exists");
    }

    public static String notAllowImageType(){
        return "Image type is not allowed (jpg, jpeg, png, svg)";
    }

    public static String notAllowFileSize(){
        return "File size must < " + ApplicationConstant.MAX_FILE_SIZE;
    }

    public static String unauthorized(){
        return "Unauthorized!";
    }
}
