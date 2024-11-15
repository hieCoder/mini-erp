package com.hieDev.minierp.security;

import com.hieDev.minierp.exception.UserLockException;
import com.hieDev.minierp.exception.UserNotFoundException;
import com.hieDev.minierp.exception.UserPendingException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        if (exception.getCause() instanceof UserNotFoundException) {
            setDefaultFailureUrl("/login?userNotFound");
        } else if (exception.getCause() instanceof UserLockException) {
            setDefaultFailureUrl("/login?userLock");
        } else if (exception.getCause() instanceof UserPendingException) {
            setDefaultFailureUrl("/login?userPending");
        } else{
            setDefaultFailureUrl("/login?passwordInvalid");
        }

        super.onAuthenticationFailure(request, response, exception);
    }
}