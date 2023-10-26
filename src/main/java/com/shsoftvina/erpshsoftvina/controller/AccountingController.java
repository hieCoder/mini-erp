package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.constant.ApplicationConstant;
import com.shsoftvina.erpshsoftvina.constant.SettingConstant;
import com.shsoftvina.erpshsoftvina.entity.Setting;
import com.shsoftvina.erpshsoftvina.mapper.SettingMapper;
import com.shsoftvina.erpshsoftvina.model.response.accounting.AccountResponse;
import com.shsoftvina.erpshsoftvina.model.response.accounting.MonthHistoryList;
import com.shsoftvina.erpshsoftvina.model.response.accounting.PageAccountListResponse;
import com.shsoftvina.erpshsoftvina.model.response.setting.SettingAllowanceResponse;
import com.shsoftvina.erpshsoftvina.service.AccountingService;
import com.shsoftvina.erpshsoftvina.service.SettingService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;

@Controller
@RequestMapping("/accounting")
@RequiredArgsConstructor
public class AccountingController {
    private final AccountingService accountingService;
    private final SettingMapper settingMapper;
    @GetMapping("/{monthId}")
    public ModelAndView showAccountingList(@PathVariable("monthId") String monthId,
                                           @RequestParam(name = "page",required = false,defaultValue = "1") Integer page,
                                           @RequestParam(name = "size", required = false, defaultValue = "10") Integer size,
                                           @RequestParam(name = "startDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                                           @RequestParam(name = "endDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        ModelAndView modelAndView = new ModelAndView("accounting/homepage");
        PageAccountListResponse listResponse = accountingService.findAccountingByMonth(monthId,page,size,startDate,endDate);
        modelAndView.addObject("list",listResponse);
        modelAndView.addObject("month",monthId);
        return modelAndView;
    }

    @GetMapping()
    public ModelAndView showAllMonthlyHistory() {
        ModelAndView modelAndView = new ModelAndView("accounting/total-month");
        MonthHistoryList monthHistoryList = accountingService.findAllMonthlyHistory();
        Setting setting = settingMapper.findByCode(SettingConstant.ACCOUNTING_CODE);

        SettingAllowanceResponse settings = new SettingAllowanceResponse(setting.getFileSize(),setting.getFileType(),setting.getImageType(),setting.getFileLimit());
        modelAndView.addObject("monthList",monthHistoryList);
        modelAndView.addObject("setting",settings);
        return modelAndView;
    }

    @GetMapping("/detail/{id}")
    public ModelAndView showAccountingDetail(@PathVariable("id") String id) {
        ModelAndView modelAndView = new ModelAndView("accounting/detail");
        AccountResponse accountingResponse = accountingService.findAccountingById(id);
        Setting setting = settingMapper.findByCode(SettingConstant.ACCOUNTING_CODE);

        SettingAllowanceResponse settings = new SettingAllowanceResponse(setting.getFileSize(),setting.getFileType(),setting.getImageType(),setting.getFileLimit());

        modelAndView.addObject("account",accountingResponse);
        modelAndView.addObject("setting",settings);
        return modelAndView;
    }
}
