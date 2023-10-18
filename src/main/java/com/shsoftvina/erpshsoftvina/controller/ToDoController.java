package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/management-time")
@RequiredArgsConstructor
public class ToDoController {
    private final ManagementTimeDayService managementTimeDayService;
    private final UserService userService;

    @GetMapping("/{userId}")
    public ModelAndView getCalendar(@PathVariable("userId") String userId,
                                    @RequestParam(value = "year", required = false) String year,
                                    @RequestParam(value = "month",required = false) String month) {
        ModelAndView modelAndView = new ModelAndView("todo/calendar");
        if (year == null && month == null) {
            LocalDateTime dateTime = LocalDateTime.now();
            List<DayResponse> responses = managementTimeDayService.findAllByMonthYear(userId, String.valueOf(dateTime.getYear()), String.valueOf(dateTime.getMonth()));
        }
        List<DayResponse> responses = managementTimeDayService.findAllByMonthYear(userId, year,month);
        modelAndView.addObject("list",responses);
        modelAndView.addObject("userId",userId);
        return modelAndView;
    }

    @GetMapping
    public ModelAndView getManagementTimeUserList() {
        ModelAndView modelAndView = new ModelAndView("todo/user-list");
        List<Map<String, Object>> list = userService.getAllFullname();
        modelAndView.addObject("list",list);
        return modelAndView;
    }
}
