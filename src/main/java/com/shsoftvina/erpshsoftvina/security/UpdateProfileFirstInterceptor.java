package com.shsoftvina.erpshsoftvina.security;

import com.shsoftvina.erpshsoftvina.entity.User;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class UpdateProfileFirstInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User currentUser = Principal.getUserCurrent();
        System.out.println(currentUser.isFirstUpdateProfile());
        if(currentUser == null) {
            response.sendRedirect("/login");
            return false;
        }

        if(!currentUser.isFirstUpdateProfile()) {
            response.sendRedirect("/hello/testUpdateProfile");
            System.out.println("Redirect to login page");
            return false;
        }
        return true;
    }
}
