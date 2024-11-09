package com.hieDev.minierp.exception;

import org.springframework.security.core.AuthenticationException;

// Define UserPendingException for overlapping cases
public class UserPendingException extends AuthenticationException {
    public UserPendingException(String message) {
        super(message);
    }
}
