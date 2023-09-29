package com.shsoftvina.erpshsoftvina.exception;

// Define NotFoundException for overlapping cases
public class NotFoundException extends RuntimeException {
    public NotFoundException(String message) {
        super(message);
    }
}
