package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/timesheets")
public class TimesheetsApi {

    @Autowired
    UserService userService;
}
