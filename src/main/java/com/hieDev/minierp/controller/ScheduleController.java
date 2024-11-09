package com.hieDev.minierp.controller;

import com.hieDev.minierp.security.Principal;
import com.hieDev.minierp.service.UserService;
import com.hieDev.minierp.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/schedules")
public class ScheduleController {
    @Autowired
    private UserService userService;
    @Autowired
    ApplicationUtils applicationUtils;

    @GetMapping
    public ModelAndView getScheduleList() {
        applicationUtils.checkUserAllow();
        ModelAndView modelAndView = new ModelAndView("schedule/list");
        List<Map<String, Object>> list = userService.getAllFullname();
        modelAndView.addObject("list",list);
        return modelAndView;
    }

    @GetMapping("/detail/")
    public String getScheduleDefault() {
        String userId = Principal.getUserCurrent().getId();
        applicationUtils.checkUserAllow(userId);
        return "redirect:/schedules/detail/"+userId;
    }

    @GetMapping("/detail/{userId}")
    public ModelAndView getScheduleDetail(@PathVariable(value = "userId", required = false) String userId) {
        if(userId.equals("")) userId = Principal.getUserCurrent().getId();
        applicationUtils.checkUserAllow(userId);
        return new ModelAndView("schedule/detail");
    }
}