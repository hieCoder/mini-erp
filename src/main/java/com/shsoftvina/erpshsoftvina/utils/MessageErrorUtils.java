package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;

public class MessageErrorUtils {
    public static String notFound(String s){
        return s.concat(" is not found");
    }

    public static String alreadyExists(String s){
        return s.concat(" already exists");
    }

    public static String notAllowImageType(String imageTypes){
        return "Image type is not allowed! (" + imageTypes + ")";
    }

    public static String notAllowFileType(String fileTypes){
        return "File type is not allowed (" + fileTypes + ")";
    }

    public static String notAllowFileLimit(int fileLimit){
        return "File count must <= " + fileLimit;
    }

    public static String notAllowFileSize(){
        return "File size must <= " + ApplicationConstant.MAX_FILE_SIZE;
    }

    public static String unauthorized(){
        return "Unauthorized!";
    }

    public static String unknown(String s){
        return s.concat(" unknown!");
    }

    public static String notAllow(String s){
        return s.concat(" is not allow");
    }
}
