package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.constant.*;
import com.shsoftvina.erpshsoftvina.entity.Accounting;
import com.shsoftvina.erpshsoftvina.entity.Contract;
import com.shsoftvina.erpshsoftvina.entity.Notification;
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
import java.util.stream.Stream;

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
            String[] parts = dir.split("upload");
            String destinationFolder = parts[parts.length-1];
            Path SavePathTarget = Paths.get(basePath + "/upload/" + destinationFolder);
            Path filePath = savePath.resolve(fileName);
            Path filePathTarget = SavePathTarget.resolve(fileName);
            try {
                if (!Files.exists(savePath)) {
                    Files.createDirectories(savePath);
                }
                if (!Files.exists(SavePathTarget)) {
                    Files.createDirectories(SavePathTarget);
                }
                Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                Files.copy(file.getInputStream(), filePathTarget, StandardCopyOption.REPLACE_EXISTING);

                return true;
            } catch (IOException e) {
                return false;
            }
        }
        return false;
    }

    public static List<String> saveMultipleFilesToServer(HttpServletRequest request, String dir, MultipartFile... files) {

        List<String> listFileName = new ArrayList<>();

        if(files == null) return listFileName;

        boolean isSuccess = true;

        for(MultipartFile file: files){
            if(file!= null){
                String fileName = formatNameImage(file);
                boolean isSave = saveImageToServer(request, dir, file, fileName);
                listFileName.add(fileName);
                if(!isSave){
                    isSuccess = false;
                    break;
                }
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

    public static void deleteMultipleFilesToServer(HttpServletRequest request,String dir, String listFileName) {
        if(listFileName != null){
            String[] fileNames = listFileName.split(",");
            for(String fn: fileNames){
                deleteImageFromServer(request, dir, fn);
            }
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
                    .map(file -> formatNameImage(file))
                    .collect(Collectors.joining(","));
        }
        return null;
    }

    public static String convertMultipartFileArrayToString(List<String> listFileNameSaveFileSuccess) {
        if (!listFileNameSaveFileSuccess.isEmpty()) {
            return listFileNameSaveFileSuccess.stream()
                    .filter(file -> file != null && !file.isEmpty())
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
            else if (c == Notification.class) {
                return NotificationConstant.PATH_FILE + fileName;
            }
            else if (c == Contract.class) {
                return ContractConstant.PATH_FILE + fileName;
            }
        }
        return null;
    }

    public static String[] getPathUploadList(Class<?> c, String fileNames) {
        if(fileNames != null && !fileNames.isEmpty()){
            String[] rs = fileNames.split(",");
            return Stream.of(rs).map(fileName -> {
                if (c == User.class) {
                    return UserConstant.PATH_FILE + fileName;
                }
                else if (c == Accounting.class) {
                    return AccountingConstant.PATH_FILE + fileName;
                }
                else if (c == Notification.class) {
                    return NotificationConstant.PATH_FILE + fileName;
                } else return null;
            }).toArray(String[]::new);
        }
        return null;
    }

    public static boolean isAllowedFileType(MultipartFile file, String listType) {
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

    public static boolean isAllowedFileType(MultipartFile[] files, String listType) {
        return Arrays.stream(files)
                .allMatch(file -> isAllowedFileType(file, listType));
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
}
