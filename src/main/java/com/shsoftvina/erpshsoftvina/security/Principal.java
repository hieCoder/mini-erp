package com.shsoftvina.erpshsoftvina.security;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import org.springframework.security.core.context.SecurityContextHolder;

public class Principal {

    public static User getUserCurrent() {
        User user = User.builder().email("canh@gmail.com")
                .password("$2a$12$f6ld0R7LiYdJ6TwzjxLxT.QJ45febxzuZV1UbDg7TQUwPf.nRvTl2")
                .role(RoleEnum.DEVELOPER)
                .status(StatusUserEnum.ACTIVE)
                .fullname("HuynhCanh")
                .build();//(User) (SecurityContextHolder.getContext()).getAuthentication().getPrincipal();
        return user;
    }
}