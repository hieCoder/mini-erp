package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;

import java.time.LocalDateTime;
import java.util.Date;
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

    @GetMapping("/{userId}/day")
    public ModelAndView getDetailDay(
            @PathVariable("userId") String userId,
            @RequestParam(name = "id", required = false, defaultValue = "") String id,
            @RequestParam(name = "day", required = false, defaultValue = "") String day
    ) {
            ModelAndView mav = new ModelAndView();
            DayResponse dayResponse = managementTimeDayService.findDayResponse(userId, day, id);
            if(dayResponse!=null){
                mav.addObject("dayResponse", dayResponse);
            } else{
                if(!StringUtils.isValidDate(day)){
                    mav.setViewName("redirect:/management-time/"+ userId);
                    return mav;
                }
                mav.addObject("day", day);
            }
            mav.setViewName("management-time/day/detail");
            return mav;
    }
    @GetMapping("/{userId}")
    public ModelAndView getCalendar(@PathVariable("userId") String userId) {
        ModelAndView modelAndView = new ModelAndView("management-time/calendar-list");
        modelAndView.addObject("userId",userId);
        return modelAndView;
    }
}
