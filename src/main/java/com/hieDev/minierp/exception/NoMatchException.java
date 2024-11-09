package com.hieDev.minierp.exception;

// Define NoMatchException for overlapping cases
public class NoMatchException extends RuntimeException {
    public NoMatchException(String message) {
        super(message);
    }
}
