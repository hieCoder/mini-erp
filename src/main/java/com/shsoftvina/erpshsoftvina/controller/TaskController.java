package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.entity.Task;
import com.shsoftvina.erpshsoftvina.mapper.TaskMapper;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/tasks")
public class TaskController {

    @Autowired
    private TaskMapper taskMapper;

    @Autowired
    private ApplicationUtils applicationUtils;

    @GetMapping
    public ModelAndView getTasks() {
        ModelAndView mav = new ModelAndView("task/tasks");
        return mav;
    }

    @GetMapping("/{id}")
    public ModelAndView getTask(@PathVariable String id) {

        Task task = taskMapper.findById(id);
        applicationUtils.checkUserAllow(task.getUser().getId());

        ModelAndView mav = new ModelAndView("task/task-detail");
        mav.addObject("id", id);
        return mav;
    }
}