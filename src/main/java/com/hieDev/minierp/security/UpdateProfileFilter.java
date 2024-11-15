package com.hieDev.minierp.security;

import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class UpdateProfileFilter extends OncePerRequestFilter {

    @Autowired
    private UserMapper userMapper;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated()) {

            if(!urlsAllow(request.getRequestURI()) || request.getRequestURI().startsWith("/users/")){
                User user = userMapper.findByEmail(Principal.getUserCurrent().getEmail());
                Principal.updateUserCurrent(user);
            }

            if (!urlsAllow(request.getRequestURI())) {
                try {
                    if (!Principal.getUserCurrent().checkAcceptUpdateBasicInfo()) {
                        response.sendRedirect("/users/" + Principal.getUserCurrent().getId());
                    } else {
                        if (request.getRequestURI().equals("/login")) {
                            response.sendRedirect("/dashboard");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        filterChain.doFilter(request, response);
    }

    private boolean urlsAllow(String u){
        String[] urls = new String[]{
                "/assets/",
                "/upload/", "/assets/upload",
                "/users/", "/forbidden",
                "/j_spring_security_check", "/api/",
                "/service-worker.js",
                "/websocket"
        };

        for(String url: urls){
            if(u.startsWith(url)) return true;
        }
        return false;
    }
}