package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/todo")
public class ToDoController {
    @Autowired
    ManagementTimeDayService managementTimeDayService;

    @GetMapping
    public String getCalendar() {
        return "todo/calendar";
    }

    @GetMapping("/day/{id}")
    public ModelAndView getDetailDay(@PathVariable("id") String id) {
        DayResponse dayResponse = managementTimeDayService.findById(id);
        ModelAndView mav = new ModelAndView("todo/detail");
        mav.addObject("dayResponse", dayResponse);
        return mav;
    }
}
