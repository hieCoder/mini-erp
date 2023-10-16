package com.shsoftvina.erpshsoftvina.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/tasks")
public class TaskController {

    @GetMapping
    public ModelAndView getTasks() {
        ModelAndView mav = new ModelAndView("task/tasks");
        return mav;
    }

    @GetMapping("/{id}")
    public ModelAndView getTask(@PathVariable String id) {
        ModelAndView mav = new ModelAndView("task/task-detail");
        mav.addObject("id", id);
        return mav;
    }
}