package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.schedule.ScheduleListResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;
import com.shsoftvina.erpshsoftvina.service.ScheduleService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/schedules")
public class ScheduleController {
    @Autowired
    private ScheduleService scheduleService;
    @Autowired
    private UserService userService;

    @GetMapping
    public ModelAndView getScheduleList() {
        ModelAndView modelAndView = new ModelAndView("schedule/list");
        List<Map<String, Object>> list = userService.getAllFullname();
        modelAndView.addObject("list",list);
        return modelAndView;
    }
    @GetMapping("/detail/{userId}")
    public ModelAndView getScheduleDetail(@PathVariable("userId") String userId,
                                          @RequestParam(required = false) Date startDate,
                                          @RequestParam(required = false) Date endDate) {
        ModelAndView modelAndView = new ModelAndView("schedule/detail");

        if (startDate == null && endDate == null) {
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.DAY_OF_MONTH, 1);
            startDate = calendar.getTime();

            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            endDate = calendar.getTime();
        }
        ScheduleListResponse list = scheduleService.getScheduleDetail(userId, startDate, endDate);
        modelAndView.addObject("schedule",list);
        return modelAndView;
    }
    @GetMapping("/1")
    public String getSchedule() {
        return "schedule/detail-2";
    }
}