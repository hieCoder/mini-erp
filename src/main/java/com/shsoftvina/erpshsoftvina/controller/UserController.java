package com.shsoftvina.erpshsoftvina.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/hello")
public class UserController {

    @GetMapping
    public String hello() {
       return "auth/index";
    }

    @GetMapping("/testUpdateProfile")
    public String testUpdateProfile() {
        return "user/testUpdateProfile";
    }
}
