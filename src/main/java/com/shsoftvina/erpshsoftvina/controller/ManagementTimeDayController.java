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
@RequestMapping("/management-time")
public class ManagementTimeDayController {

    @Autowired
    ManagementTimeDayService managementTimeDayService;

    @GetMapping("/{idUser}")
    public String getCalendarDetail(@PathVariable String idUser) {
        return "management-time/calendar-detail";
    }

    @GetMapping("/day")
    public ModelAndView getDetailDay(
            @RequestParam(name = "id", required = false, defaultValue = "") String id,
            @RequestParam(name = "day", required = false, defaultValue = "") String day
    ) {
        ModelAndView mav = new ModelAndView("management-time/day/detail");
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
