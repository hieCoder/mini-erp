package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.user.PageUserListRespone;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.service.ContractService;
import com.shsoftvina.erpshsoftvina.service.TimesheetsService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    TimesheetsService timesheetsService;

    @Autowired
    ContractService contractService;

    @GetMapping
    public ModelAndView showListUser(@RequestParam(name = "sort", required = false, defaultValue = "asc") String sort,
                                     @RequestParam(name = "search", required = false, defaultValue = "") String search,
                                     @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                     @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize,
                                     @RequestParam(name = "status", required = false, defaultValue = "ACTIVE") String status) {
        ModelAndView view = new ModelAndView("user/listUser");

        PageUserListRespone users = userService.getAllUser(search, sort, page, pageSize, status);

        view.addObject("users", users);

        return view;
    }

    @GetMapping("/{id}")
    public ModelAndView showUserDetail(@PathVariable("id") String id) {
        ModelAndView view = new ModelAndView("user/userDetail");

        UserDetailResponse user = userService.findUserDetail(id);
        view.addObject("user", user);
        return view;
    }

}
