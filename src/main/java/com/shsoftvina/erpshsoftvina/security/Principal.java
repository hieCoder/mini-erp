package com.shsoftvina.erpshsoftvina.security;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import org.springframework.security.core.context.SecurityContextHolder;

public class Principal {

    public static User getUserCurrent() {

        return (User) (SecurityContextHolder.getContext()).getAuthentication().getPrincipal();
    }
}