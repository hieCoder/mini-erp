package com.shsoftvina.erpshsoftvina.ultis;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
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

    public static boolean saveMultipleFilesToServer(HttpServletRequest request, String dir, MultipartFile[] files) {
        if (files != null && files.length <= 3) {
            String basePath = request.getSession().getServletContext().getRealPath("/");
            String grandparentPath = Paths.get(basePath).getParent().getParent().toString();
            Path savePath = Paths.get(grandparentPath + dir);

            try {
                if (!Files.exists(savePath)) {
                    Files.createDirectories(savePath);
                }

                for (MultipartFile file : files) {
                    if (!file.isEmpty()) {
                        String fileName = file.getOriginalFilename();
                        Path filePath = savePath.resolve(fileName);
                        Files.copy(file.getInputStream(), filePath);
                    }
                }

                return true;
            } catch (IOException e) {
                return false;
            }
        }
        return false;
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
//        if (files != null && files.length > 0) {
//            return Arrays.stream(files)
//                    .map(file -> {
//                        return formatNameImage(file);
//                    })
//                    .collect(Collectors.joining(","));
//        }
//        return "";
        if (files != null) {
            return Arrays.stream(files)
                    .filter(file -> file != null && !file.isEmpty())
                    .map(file -> {
                        return formatNameImage(file);
                    })
                    .collect(Collectors.joining(","));
        }
        return "";
    }
}
