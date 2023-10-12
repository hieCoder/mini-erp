package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.response.contract.ContractResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.PageUserListRespone;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.UserShowResponse;
import com.shsoftvina.erpshsoftvina.service.ContractService;
import com.shsoftvina.erpshsoftvina.service.TimesheetsService;
import com.shsoftvina.erpshsoftvina.service.UserService;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/")
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    TimesheetsService timesheetsService;

    @Autowired
    ContractService contractService;

    @GetMapping("/home")
    public String hello() {
        System.out.println("01");
        return "auth/index";
    }

    @GetMapping("/testUpdateProfile")
    public String testUpdateProfile() {
        System.out.println("02");
        return "user/testUpdateProfile";
    }

    @GetMapping("/users")
    public ModelAndView showListUser(@RequestParam(name = "sort", required = false, defaultValue = "asc") String sort,
                                     @RequestParam(name = "search", required = false, defaultValue = "") String search,
                                     @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                     @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize,
                                     @RequestParam(name = "status", required = false, defaultValue = "ACTIVE") String status) {
        ModelAndView view = new ModelAndView("user/get-list");

        PageUserListRespone users = userService.getAllUser(search, sort, page, pageSize, status);

        view.addObject("users", users);

        return view;
    }

    @GetMapping("/userDetail/{id}")
    public ModelAndView showUserDetail(@PathVariable("id") String id,
                                       @RequestParam(name = "year", required = false) String year) {
        ModelAndView view = new ModelAndView("user/userDetail");

        UserDetailResponse user = userService.findUserDetail(id);
        List<Map<String, ?>> workingDay = timesheetsService.getTotalWorkingDate(id, year);
        List<ContractResponse> contractUser = contractService.getContractByUser(id);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String dateOfBirth = sdf.format(user.getDateOfBirth());


        view.addObject("user", user);
        view.addObject("dateOfBirth", dateOfBirth);
        view.addObject("workingDay", workingDay);
        view.addObject("contractUser", contractUser);

        return view;
    }

}
