package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.response.weeklyReport.PageWeeklyReportListRespone;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.TaskService;
import com.shsoftvina.erpshsoftvina.service.WeeklyReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/weeklyReports")
public class weeklyReportController {

    @Autowired
    WeeklyReportService weeklyReportService;

    @Autowired
    TaskService taskService;

    @GetMapping
    public ModelAndView showListWeeklyReport(@RequestParam(name = "search", required = false, defaultValue = "") String search,
                                             @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                             @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize) {
        ModelAndView view = new ModelAndView("weeklyReport/listWeeklyReport");

        User user =  Principal.getUserCurrent();
        PageWeeklyReportListRespone weeklyReports = weeklyReportService.getAllWeeklyReport(search, user.getRole().getValue(), page, pageSize);


        view.addObject("user", user);
        view.addObject("weeklyReports", weeklyReports);
        return view;
    }

}
