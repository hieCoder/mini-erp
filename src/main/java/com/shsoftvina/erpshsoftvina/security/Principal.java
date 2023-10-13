package com.shsoftvina.erpshsoftvina.security;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import org.springframework.security.core.context.SecurityContextHolder;

public class Principal {

    public static User getUserCurrent() {
        User user = User.builder()
                .id("21")
                .email("hieu11@gmail.com")
                .password("$2a$10$ANk.9FRk6K6IpfU0Q5o4zer6/lHWb7uy7.l9n.SAmQIk6IqvJn1/i")
                .role(RoleEnum.OWNER)
                .status(StatusUserEnum.ACTIVE)
                .fullname("trunghieu")
                .isFirstUpdateProfile(true)
                .build();//(User) (SecurityContextHolder.getContext()).getAuthentication().getPrincipal();
        return user;
    }
}