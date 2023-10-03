package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.constant.AccountingConstant;
import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.exception.FileSizeNotAllowException;
import com.shsoftvina.erpshsoftvina.exception.FileTypeNotAllowException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class FileUtils {

    public static String formatNameImage(MultipartFile file){
        if(file!=null){
            return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMddHHmmss-")) + file.getOriginalFilename();
        }
        return null;
    }

    public static boolean saveImageToServer(HttpServletRequest request, String dir, MultipartFile file, String fileName) {
        if(file != null && fileName != null){
            String basePath = request.getSession().getServletContext().getRealPath("/");
            String grandparentPath = Paths.get(basePath).getParent().getParent().toString();
            Path savePath = Paths.get(grandparentPath + dir);
            Path filePath = savePath.resolve(fileName);
            try {
                if (!Files.exists(savePath)) {
                    Files.createDirectories(savePath);
                }
                Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                return true;
            } catch (IOException e) {
                return false;
            }
        }
        return false;
    }

    public static List saveMultipleFilesToServer(HttpServletRequest request, String dir, MultipartFile[] files) {

        List<String> listFileName = new ArrayList<>();

        boolean isSuccess = true;

        for(MultipartFile file: files){
            String fileName = formatNameImage(file);
            boolean isSave = saveImageToServer(request, dir, file, fileName);
            listFileName.add(fileName);
            if(!isSave){
                isSuccess = false;
                break;
            }
        }

        if(!isSuccess){
            for(String fileName: listFileName){
                deleteImageFromServer(request, dir, fileName);
            }
            return null;
        }
        return listFileName;
    }

    public static void deleteMultipleFilesToServer(HttpServletRequest request,String dir, String fileName) {
        String[] fileNames = fileName.split(",");
        for(String fn: fileNames){
            deleteImageFromServer(request, dir, fn);
        }
    }

    public static boolean deleteImageFromServer(HttpServletRequest request,String dir, String fileName) {
        String basePath = request.getSession().getServletContext().getRealPath("/");
        String grandparentPath = Paths.get(basePath).getParent().getParent().toString();
        Path deletePath = Paths.get(grandparentPath + dir + fileName);
        if (Files.exists(deletePath)) {
            try {
                Files.delete(deletePath);
                return true;
            } catch (IOException e) {
                return false;
            }
        }
        return false;
    }

    public static String convertMultipartFileArrayToString(MultipartFile[] files) {
        if (files != null) {
            return Arrays.stream(files)
                    .filter(file -> file != null && !file.isEmpty())
                    .map(file -> {
                        return formatNameImage(file);
                    })
                    .collect(Collectors.joining(","));
        }
        return null;
    }

    public static String getPathUpload(Class<?> c, String fileName) {
        if(fileName != null){
            if (c == User.class) {
                return UserConstant.PATH_FILE + fileName;
            }
            else if (c == Accounting.class) {
                return AccountingConstant.PATH_FILE + fileName;
            }
        }
        return null;
    }

    public static boolean isAllowedImageType(MultipartFile file, String listType) {
        String originalFileName = file.getOriginalFilename();
        if (originalFileName != null) {
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf(".") + 1).toLowerCase();
            String[] allowedExtensions = listType.split(",");

            for (String allowedExtension : allowedExtensions) {
                if (fileExtension.equals(allowedExtension.trim().toLowerCase())) return true;
            }
        }
        return false;
    }

    public static long parseFileSize(String size) {
        if (size.endsWith("MB")) {
            return Long.parseLong(size.substring(0, size.length() - 2)) * 1024 * 1024;
        }
        return Long.parseLong(size);
    }

    public static boolean isAllowedFileSize(MultipartFile file) {
        long fileSizeInBytes = file.getSize();
        long maxFileSizeInBytes = parseFileSize(ApplicationConstant.MAX_FILE_SIZE);
        long maxRequestSizeInBytes = parseFileSize(ApplicationConstant.MAX_REQUEST_SIZE);

        return fileSizeInBytes <= maxFileSizeInBytes && fileSizeInBytes <= maxRequestSizeInBytes;
    }

    public static void validateFiles(MultipartFile[] files) {
        for (MultipartFile file : files) {
            if (!isAllowedImageType(file, AccountingConstant.LIST_TYPE_FILE)) {
                throw new FileTypeNotAllowException(MessageErrorUtils.notAllowFileType());
            }
            if (!isAllowedFileSize(file)) {
                throw new FileSizeNotAllowException(MessageErrorUtils.notAllowFileSize());
            }
        }
    }
}
