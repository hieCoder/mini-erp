package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.notification.NotificationShowResponse;
import com.shsoftvina.erpshsoftvina.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/notifications")
public class NotificationController {

    @Autowired
    NotificationService notificationService;

    @GetMapping
    public String getList(
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "pageSize", defaultValue = "10") int pageSize,
            Model model
    ) {
        List<NotificationShowResponse> listNotification = notificationService.getAllNoti((page - 1) * pageSize, pageSize);
        int totalNotification = notificationService.countAll(); // Total number of notes
        int totalPages = (totalNotification + pageSize - 1) / pageSize;
        model.addAttribute("listNotification", listNotification);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "notification/get-list";
    }
}
