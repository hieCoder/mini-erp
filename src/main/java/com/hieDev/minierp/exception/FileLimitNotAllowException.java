package com.hieDev.minierp.exception;

public class FileLimitNotAllowException extends RuntimeException {
    public FileLimitNotAllowException(String message) {
        super(message);
    }
}
