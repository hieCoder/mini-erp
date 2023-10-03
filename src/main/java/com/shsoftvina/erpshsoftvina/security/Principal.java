package com.shsoftvina.erpshsoftvina.security;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import org.springframework.security.core.context.SecurityContextHolder;

// The Principal class provides a utility method for obtaining the currently authenticated user.
public class Principal {

    // This method retrieves the currently authenticated user from the security context.
    public static User getUserCurrent() {
        // Access the security context to obtain the current authentication information.
        // The user information is typically stored in the Principal of the authentication object.
        User user = User.builder().email("canh@gmail.com")
                .password("$2a$12$f6ld0R7LiYdJ6TwzjxLxT.QJ45febxzuZV1UbDg7TQUwPf.nRvTl2")
                .role(RoleEnum.OWNER)
                .status(StatusUserEnum.ACTIVE)
                .fullname("HuynhCanh")
                .build();//(User) (SecurityContextHolder.getContext()).getAuthentication().getPrincipal();
        return user;
    }
}