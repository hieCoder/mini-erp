package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.response.timesheets.TimesheetsResponse;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface TimesheetsService {
    List<TimesheetsResponse> findAllByUserAndMonthYear(String userId, int year, int month);
    List<Map<String, ?>> getTotalWorkDayByYear(String userID);
    List<Map<String, ?>> getTotalWorkDayByMonth(String userID, String year);
    boolean readExcelFile(MultipartFile file);
}