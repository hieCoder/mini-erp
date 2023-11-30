package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.user.IdAndFullnameUserResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/management-time")
public class ManagementTimeDayController {

    @Autowired
    ManagementTimeDayService managementTimeDayService;

    @Autowired
    UserService userService;

    @Autowired
    ApplicationUtils applicationUtils;

    @GetMapping
    public ModelAndView getUser() {
        ModelAndView view = new ModelAndView("management-time/users-calendar");
        List<Map<String, Object>> list = userService.getAllFullname();
        view.addObject("list", list);
        return view;
    }

    @GetMapping("/weekly-detail/{userId}")
    public ModelAndView getDetailDay(@PathVariable String userId, @RequestParam(name = "currentDay", required = false, defaultValue = "") String currentDay) {
        ModelAndView mav = new ModelAndView("management-time/day/week-detail");
        mav.addObject("weekly",managementTimeDayService.showListDayOfWeek(userId, currentDay));
        IdAndFullnameUserResponse user = userService.findIdAndFullNameOfUser(userId);
        mav.addObject("user", user);
        return mav;
    }

    @GetMapping("/{userId}")
    public ModelAndView getCalendar(@PathVariable("userId") String userId) {
        ModelAndView modelAndView = new ModelAndView("management-time/calendar-list");
        IdAndFullnameUserResponse user = userService.findIdAndFullNameOfUser(userId);
        modelAndView.addObject("user", user);
        return modelAndView;
    }
}

