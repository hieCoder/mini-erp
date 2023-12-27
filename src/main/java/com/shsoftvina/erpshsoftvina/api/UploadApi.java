package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.constant.QuoteConstant;
import com.shsoftvina.erpshsoftvina.entity.CommentTask;
import com.shsoftvina.erpshsoftvina.mapper.SettingMapper;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;


@RestController
@RequestMapping("/api/v1/upload")
public class UploadApi {

    @Autowired
    private ApplicationUtils applicationUtils;

    @Autowired
    private SettingMapper settingMapper;

    @PostMapping
    public ResponseEntity<?> uploadFile(MultipartFile[] files, @RequestParam String typeFile) {
        List<String> listFileNameSaveFileSuccess = null;
        listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(getDir(typeFile), files);
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
