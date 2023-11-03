package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.event.EventResponse;
import com.shsoftvina.erpshsoftvina.service.EventService;
import com.shsoftvina.erpshsoftvina.service.ScheduleService;
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
@RequestMapping("/schedules")
public class ScheduleController {
    @Autowired
    private ScheduleService scheduleService;
    @Autowired
    private EventService eventService;
    @Autowired
    private UserService userService;
    @Autowired
    ApplicationUtils applicationUtils;

    @GetMapping
    public ModelAndView getScheduleList() {
        ModelAndView modelAndView = new ModelAndView("schedule/list");
        List<Map<String, Object>> list = userService.getAllFullname();
        modelAndView.addObject("list",list);
        return modelAndView;
    }

    @GetMapping("/detail/{userId}")
    public ModelAndView getScheduleDetail(@PathVariable("userId") String userId) {
        applicationUtils.checkUserAllow(userId);
        ModelAndView modelAndView = new ModelAndView("schedule/detail");
        return modelAndView;
    }

}