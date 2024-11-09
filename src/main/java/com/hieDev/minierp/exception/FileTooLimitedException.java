package com.hieDev.minierp.exception;

// Define FileTooLimitedException for overlapping cases
public class FileTooLimitedException extends RuntimeException {
    public FileTooLimitedException(String message) {
        super(message);
    }
}
