package com.shsoftvina.erpshsoftvina.security;

import com.shsoftvina.erpshsoftvina.entity.User;
import org.springframework.security.core.context.SecurityContextHolder;

// The Principal class provides a utility method for obtaining the currently authenticated user.
public class Principal {

    // This method retrieves the currently authenticated user from the security context.
    public static User getUserCurrent() {
        // Access the security context to obtain the current authentication information.
        // The user information is typically stored in the Principal of the authentication object.
        User user = (User) (SecurityContextHolder.getContext()).getAuthentication().getPrincipal();
        return user;
    }
}
