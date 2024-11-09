package com.hieDev.minierp.exception;

// Defines UnauthorizedException for cases where there is no access
public class UnauthorizedException extends RuntimeException {
    public UnauthorizedException(String message) {
        super(message);
    }
}
