package com.hieDev.minierp.exception;

// Define NoMatchException for overlapping cases
public class FileTypeNotAllowException extends RuntimeException {
    public FileTypeNotAllowException(String message) {
        super(message);
    }
}
