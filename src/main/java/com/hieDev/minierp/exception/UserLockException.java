package com.hieDev.minierp.exception;

import org.springframework.security.core.AuthenticationException;

// Define UserLockException for overlapping cases
public class UserLockException extends AuthenticationException {
    public UserLockException(String message) {
        super(message);
    }
}
