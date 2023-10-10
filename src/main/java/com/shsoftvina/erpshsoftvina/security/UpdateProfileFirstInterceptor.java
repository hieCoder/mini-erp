package com.shsoftvina.erpshsoftvina.security;

import com.shsoftvina.erpshsoftvina.entity.User;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class UpdateProfileFirstInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        User currentUser = Principal.getUserCurrent();
        if(currentUser == null) {
            response.sendRedirect("/login");
            return false;
        }
        if(!currentUser.isFirstUpdateProfile() && !request.getRequestURI().startsWith("/assets/")) {
            request.getRequestDispatcher("/testUpdateProfile").forward(request, response);
        }
        return true;
    }
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {System.out.println("Redirect to login page2");
    }
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {System.out.println("Redirect to login page3");
    }
}
