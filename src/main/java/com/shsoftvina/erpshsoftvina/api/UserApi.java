package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/users")
public class UserApi {

    @Autowired
    UserService userService;
}
