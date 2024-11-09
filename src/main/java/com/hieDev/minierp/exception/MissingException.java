package com.hieDev.minierp.exception;

// Define MissingException for overlapping cases
public class MissingException extends RuntimeException {
    public MissingException(String message) {
        super(message);
    }
}
