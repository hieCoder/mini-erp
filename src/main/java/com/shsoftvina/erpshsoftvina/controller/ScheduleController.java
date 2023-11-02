package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.event.EventResponse;
import com.shsoftvina.erpshsoftvina.model.response.schedule.ScheduleListResponse;
import com.shsoftvina.erpshsoftvina.model.response.task.TaskShowResponse;
import com.shsoftvina.erpshsoftvina.service.EventService;
import com.shsoftvina.erpshsoftvina.service.ScheduleService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
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
    @GetMapping("/1")
    public ModelAndView getScheduleDetail1() {
        return new ModelAndView("schedule/detail-test");
    }
    @GetMapping("/detail/{userId}")
    public ModelAndView getScheduleDetail(@PathVariable("userId") String userId,@RequestParam("month") String month) {
        applicationUtils.checkUserAllow(userId);
        ModelAndView modelAndView = new ModelAndView("schedule/detail");
        List<EventResponse> responses = eventService.getAllEventsByMonth(month);
        modelAndView.addObject("userId",userId);
        return modelAndView;
    }

    @GetMapping("/test")
    public ModelAndView getScheduleDetailTest() {
        ModelAndView modelAndView = new ModelAndView("schedule/test");
        return modelAndView;
    }
}