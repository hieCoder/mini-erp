package com.shsoftvina.erpshsoftvina.security;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import org.springframework.security.core.context.SecurityContextHolder;

public class Principal {

    public static User getUserCurrent() {
        User user = User.builder()
                .id("b0e9aca9-393e-4be5-9e06-7f8e5d7f4ba9")
                .avatar("231003123245-Cat03.jpg")
                .email("canh@gmail.com")
                .password("$2a$12$f6ld0R7LiYdJ6TwzjxLxT.QJ45febxzuZV1UbDg7TQUwPf.nRvTl2")
                .role(RoleEnum.OWNER)
                .status(StatusUserEnum.ACTIVE)
                .fullname("HuynhCanh")
                .isFirstUpdateProfile(true)
                .build();//(User) (SecurityContextHolder.getContext()).getAuthentication().getPrincipal();
        return user;
    }
}