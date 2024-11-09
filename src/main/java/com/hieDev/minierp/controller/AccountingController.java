package com.hieDev.minierp.controller;

import com.hieDev.minierp.constant.SettingConstant;
import com.hieDev.minierp.entity.Setting;
import com.hieDev.minierp.mapper.SettingMapper;
import com.hieDev.minierp.model.response.accounting.AccountResponse;
import com.hieDev.minierp.model.response.accounting.PageAccountListResponse;
import com.hieDev.minierp.model.response.setting.SettingAllowanceResponse;
import com.hieDev.minierp.service.AccountingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.util.concurrent.CompletableFuture;

@Controller
@RequestMapping("/accounting")
@RequiredArgsConstructor
public class AccountingController {
    private final AccountingService accountingService;
    private final SettingMapper settingMapper;

    @GetMapping()
    public ModelAndView showAccountingList(@RequestParam(name = "page", required = false, defaultValue = "1") Integer page,
                                           @RequestParam(name = "size", required = false, defaultValue = "10") Integer size) {
        ModelAndView modelAndView = new ModelAndView("accounting/homepage");
        LocalDate today = LocalDate.now();
        LocalDate startDate = today.withDayOfMonth(1);
        LocalDate endDate = today.withDayOfMonth(today.lengthOfMonth());
        CompletableFuture<PageAccountListResponse> futureListResponse = CompletableFuture.supplyAsync(() ->
                accountingService.findAccountingByMonth(page, size, startDate, endDate));
        CompletableFuture<SettingAllowanceResponse> futureSettings = CompletableFuture.supplyAsync(() -> {
            Setting setting = settingMapper.findByCode(SettingConstant.ACCOUNTING_CODE);
            return new SettingAllowanceResponse(setting.getFileSize(), setting.getFileType(), setting.getImageType(), setting.getFileLimit());
        });
        CompletableFuture.allOf(futureListResponse,futureSettings).join();
        modelAndView.addObject("list", futureListResponse.join());
        modelAndView.addObject("setting", futureSettings.join());
        return modelAndView;
    }

    @GetMapping("/detail/{id}")
    public ModelAndView showAccountingDetail(@PathVariable("id") String id) {
        ModelAndView modelAndView = new ModelAndView("accounting/detail");
        CompletableFuture<AccountResponse> accountingResponse = CompletableFuture.supplyAsync(() ->
                accountingService.findAccountingById(id));
        CompletableFuture<SettingAllowanceResponse> futureSettings = CompletableFuture.supplyAsync(() -> {
            Setting setting = settingMapper.findByCode(SettingConstant.ACCOUNTING_CODE);
            return new SettingAllowanceResponse(setting.getFileSize(), setting.getFileType(), setting.getImageType(), setting.getFileLimit());
        });
        CompletableFuture.allOf(accountingResponse,futureSettings).join();
        modelAndView.addObject("account", accountingResponse.join());
        modelAndView.addObject("setting", futureSettings.join());
        return modelAndView;
    }
}
