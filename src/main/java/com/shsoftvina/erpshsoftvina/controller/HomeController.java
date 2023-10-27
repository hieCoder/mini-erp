package com.shsoftvina.erpshsoftvina.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping("/")
    public String getHomePage() {
        return "common/frontpage";
    }

    @GetMapping("/home")
    public String getFrontPage() {
        return "common/frontpage";
    }
}
