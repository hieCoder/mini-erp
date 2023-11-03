package com.shsoftvina.erpshsoftvina.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/weekly-reports")
public class WeeklyReportController {

    @GetMapping
    public ModelAndView showListWeeklyReport() {
        ModelAndView view = new ModelAndView("weekly-report/list-weekly-report");
        return view;
    }
}
