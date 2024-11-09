package com.hieDev.minierp.exception;

// Define NotFoundException for overlapping cases
public class InvalidException extends RuntimeException {
    public InvalidException(String message) {
        super(message);
    }
}
