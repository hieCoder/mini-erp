package com.hieDev.minierp.controller;

import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class HomeController {
    private final UserService userService;
    @GetMapping({"/","/home","/dashboard"})
    public ModelAndView getHomePage() {
        ModelAndView modelAndView = new ModelAndView("common/frontpage");
        List<User> userResponse= userService.findUserBirthdayToday();
        modelAndView.addObject("list",userResponse);
        return modelAndView;
    }
}
