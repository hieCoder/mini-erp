package com.shsoftvina.erpshsoftvina.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class UserController {

    @GetMapping("/home")
    public String getFrontPage() {
        return "common/frontpage";
    }

    @GetMapping("/testUpdateProfile")
    public String testUpdateProfile() {
        System.out.println("02");
        return "user/testUpdateProfile";
    }
}
