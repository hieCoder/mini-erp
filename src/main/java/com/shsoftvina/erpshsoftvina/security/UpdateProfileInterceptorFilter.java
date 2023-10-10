package com.shsoftvina.erpshsoftvina.security;

import lombok.SneakyThrows;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UpdateProfileInterceptorFilter extends OncePerRequestFilter {

    private final UpdateProfileFirstInterceptor updateProfileFirstInterceptor;

    public UpdateProfileInterceptorFilter(UpdateProfileFirstInterceptor updateProfileFirstInterceptor) {
        this.updateProfileFirstInterceptor = updateProfileFirstInterceptor;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated()) {
            try {
                updateProfileFirstInterceptor.preHandle(request, response, null);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        filterChain.doFilter(request, response);
    }
}
