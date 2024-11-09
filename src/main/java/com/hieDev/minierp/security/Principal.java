package com.hieDev.minierp.security;

import com.hieDev.minierp.entity.User;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class Principal {

    public static Authentication getAuthentication() {
        return (SecurityContextHolder.getContext()).getAuthentication();
    }

    public static User getUserCurrent() {
        return (User) getAuthentication().getPrincipal();
    }

    public static void updateUserCurrent(User user){
        UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(user, getAuthentication(), user.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(newAuth);
    }
}