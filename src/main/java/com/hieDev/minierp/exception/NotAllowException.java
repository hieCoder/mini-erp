package com.hieDev.minierp.exception;

// Define InvalidException for overlapping cases
public class NotAllowException extends RuntimeException {
    public NotAllowException(String message) {
        super(message);
    }
}
