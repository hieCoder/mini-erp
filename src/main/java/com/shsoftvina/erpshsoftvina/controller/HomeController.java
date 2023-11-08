package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.response.user.IdAndFullnameUserResponse;
import com.shsoftvina.erpshsoftvina.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class HomeController {
    private final UserService userService;
    @GetMapping({"/","/home","/dashboard"})
    public ModelAndView getHomePage() {
        ModelAndView modelAndView = new ModelAndView("common/frontpage");
        LocalDate date = LocalDate.now();
        List<User> userResponse= userService.findUserBirthdayToday(date);
        modelAndView.addObject("list",userResponse);
        return modelAndView;
    }

}
