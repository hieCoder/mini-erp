package com.shsoftvina.erpshsoftvina.exception;

// Defines DuplicateException for cases where there is no access
public class UnauthorizedException extends RuntimeException {
    public UnauthorizedException(String message) {
        super(message);
    }
}
