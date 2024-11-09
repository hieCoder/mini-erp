package com.hieDev.minierp.exception;

// Define InvalidException for overlapping cases
public class NotFoundException extends RuntimeException {
    public NotFoundException(String message) {
        super(message);
    }
}
