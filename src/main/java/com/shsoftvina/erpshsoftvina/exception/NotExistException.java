package com.shsoftvina.erpshsoftvina.exception;

// Define NotExistException for overlapping cases
public class NotExistException extends RuntimeException {
    public NotExistException(String message) {
        super(message);
    }
}
