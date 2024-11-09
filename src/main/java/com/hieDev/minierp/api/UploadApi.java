package com.hieDev.minierp.api;

import com.hieDev.minierp.constant.QuoteConstant;
import com.hieDev.minierp.utils.FileUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


@RestController
@RequestMapping("/api/v1/upload")
public class UploadApi {

    @PostMapping
    public ResponseEntity<?> uploadFile(MultipartFile[] files, @RequestParam String typeFile) {
        List<String> listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(getDir(typeFile), files);
        return ResponseEntity.ok(listFileNameSaveFileSuccess);
    }

    private String getDir(String typeFile){
        String rs = "";
        switch (typeFile){
            case "QUOTE":{
                rs = QuoteConstant.UPLOAD_FILE_DIR;
                break;
            }
        }
        return rs;
    }
}
