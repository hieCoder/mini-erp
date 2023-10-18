package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;

@Controller
@RequestMapping("/todo")
public class ToDoController {
    @Autowired
    ManagementTimeDayService managementTimeDayService;

    @GetMapping
    public String getCalendar() {
        return "todo/calendar";
    }

    @GetMapping("/day")
    public ModelAndView getDetailDay(
            @RequestParam(name = "id", required = false, defaultValue = "") String id,
            @RequestParam(name = "day", required = false, defaultValue = "") String day
    ) {
        ModelAndView mav = new ModelAndView("todo/detail");
        try {
            DayResponse dayResponse = managementTimeDayService.findById(id);
            mav.addObject("dayResponse", dayResponse);
            return mav;
        }catch(Exception e){
            mav.addObject("day", day);
        } finally {
            return mav;
        }
    }
}
