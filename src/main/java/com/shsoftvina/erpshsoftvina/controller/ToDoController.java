package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.DayResponse;
import com.shsoftvina.erpshsoftvina.service.ManagementTimeDayService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/management-time")
@RequiredArgsConstructor
public class ToDoController {
    private final ManagementTimeDayService managementTimeDayService;

    @GetMapping("/{userId}")
    public ModelAndView getCalendar(@PathVariable("userId") String userId,
                                    @RequestParam("year") String year,
                                    @RequestParam("month") String month) {
        ModelAndView modelAndView = new ModelAndView("todo/calendar");
        List<DayResponse> responses = managementTimeDayService.findAllByMonthYear(userId, year, month);
        modelAndView.addObject("list",responses);
        return modelAndView;
    }

    @GetMapping()
    public String view() {
        return "todo/test";
    }

}
