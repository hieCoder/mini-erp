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
    public ModelAndView getDetailDay(
            @PathVariable String userId,
            @RequestParam(name = "currentDay", required = false, defaultValue = "") String currentDay
    ) {
        applicationUtils.checkUserAllow(userId);
        ModelAndView mav = new ModelAndView();
//        DayResponse dayResponse = managementTimeDayService.findDayResponse(userId, day, id);
//        if (dayResponse != null) {
//            mav.addObject("dayResponse", dayResponse);
//        } else {
//            if (!DateUtils.isValidDate(day)) {
//                mav.setViewName("redirect:/management-time/" + userId);
//                return mav;
//            }
//            mav.addObject("day", day);
//        }
        mav.addObject("weekly",managementTimeDayService.showListDayOfWeek(userId, currentDay));
        mav.setViewName("management-time/day/week-detail");
        mav.addObject("userId", userId);
        return mav;
    }

    @GetMapping("/{userId}")
    public ModelAndView getCalendar(@PathVariable("userId") String userId) {
        applicationUtils.checkUserAllow(userId);
        ModelAndView modelAndView = new ModelAndView("management-time/calendar-list");
        IdAndFullnameUserResponse user = userService.findIdAndFullNameOfUser(userId);
        modelAndView.addObject("user", user);
        return modelAndView;
    }
}

