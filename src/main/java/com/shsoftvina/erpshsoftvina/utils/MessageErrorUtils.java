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
        return "Image type is not allowed! (jpg, jpeg, png, svg)";
    }

    public static String notAllowFileType(){
        return "File type is not allowed (pdf, csv, xlsx, doc, xls, pptx)";
    }

    public static String notAllowFileSize(){
        return "File count must < " + ApplicationConstant.NUMBER_UPLOAD_FILE_LIMIT;
    }

    public static String unauthorized(){
        return "Unauthorized!";
    }

    public static String unknown(String s){
        return s.concat(" unknown!");
    }
}
