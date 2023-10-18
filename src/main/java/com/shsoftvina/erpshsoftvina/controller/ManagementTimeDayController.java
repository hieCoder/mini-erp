package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.service.UserService;
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

import java.time.LocalDateTime;
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
    @GetMapping("/{userId}")
    public ModelAndView getCalendar(@PathVariable("userId") String userId,
                                    @RequestParam(value = "year", required = false) String year,
                                    @RequestParam(value = "month",required = false) String month) {
        ModelAndView modelAndView = new ModelAndView("management-time/calendar-list");
        if (year == null && month == null) {
            LocalDateTime dateTime = LocalDateTime.now();
            List<DayResponse> responses = managementTimeDayService.findAllByMonthYear(userId, String.valueOf(dateTime.getYear()), String.valueOf(dateTime.getMonth()));
        }
        List<DayResponse> responses = managementTimeDayService.findAllByMonthYear(userId, year,month);
        modelAndView.addObject("list",responses);
        modelAndView.addObject("userId",userId);
        return modelAndView;
    }

}
