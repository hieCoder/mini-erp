package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
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

    @GetMapping
    public ModelAndView getUser() {
        ModelAndView view = new ModelAndView("management-time/users-calendar");

        List<Map<String, Object>> users = userService.getAllFullname();

        view.addObject("users", users);
        return view;
    }

    @GetMapping("/{idUser}")
    public String getCalendarDetail(@PathVariable String idUser) {
        return "management-time/calendar-detail";
    }

    @GetMapping("/day/{id}")
    public ModelAndView getDetailDay(@PathVariable("id") String id) {
        DayResponse dayResponse = managementTimeDayService.findById(id);
        ModelAndView mav = new ModelAndView("management-time/day/detail");
        mav.addObject("dayResponse", dayResponse);
        return mav;
    }
}
