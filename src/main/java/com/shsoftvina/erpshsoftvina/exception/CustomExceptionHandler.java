package com.shsoftvina.erpshsoftvina.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

// Annotating this class with @RestControllerAdvice designates it as a global exception handler
// for the entire application, allowing it to handle exceptions thrown during request processing.
@RestControllerAdvice
public class CustomExceptionHandler {

    // Handle UnauthorizedException and return an ErrorResponse with HTTP status 401 (Unauthorized).
    @ExceptionHandler(UnauthorizedException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public ErrorResponse handleUnauthorizedException(UnauthorizedException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.UNAUTHORIZED, ex.getMessage());
    }

    // Handle DuplicateException and return an ErrorResponse with HTTP status 409 (Conflict).
    @ExceptionHandler(DuplicateException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public ErrorResponse handleDuplicateException(DuplicateException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.CONFLICT, ex.getMessage());
    }

    // Handle FileTooLimitedException and return an ErrorResponse with HTTP status 500 (Internal Server Error).
    @ExceptionHandler(FileTooLimitedException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleFileTooLimitedException(FileTooLimitedException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    // Handle NotFoundException and return an ErrorResponse with HTTP status 500 (Internal Server Error).
    @ExceptionHandler(NotFoundException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleNotFoundException(NotFoundException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    // Handle DuplicateException and return an ErrorResponse with HTTP status 409 (Conflict).
    @ExceptionHandler(NoMatchException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleNoMatchException(NoMatchException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    // Handle FileTypeNotAllowException and return an ErrorResponse with HTTP status 500 (Internal Server Error).
    @ExceptionHandler(FileTypeNotAllowException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleFileTypeNotAllowException(FileTypeNotAllowException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    // Handle FileSizeNotAllowException and return an ErrorResponse with HTTP status 500 (Internal Server Error).
    @ExceptionHandler(FileSizeNotAllowException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleFileSizeNotAllowException(FileSizeNotAllowException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    // Handle MethodArgumentNotValidException and return an ErrorResponse with HTTP status 400 (Bad Request).
    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handleMethodArgumentNotValidException(MethodArgumentNotValidException e, WebRequest req) {
        return new ErrorResponse(HttpStatus.BAD_REQUEST,
                e.getBindingResult().getAllErrors().get(0).getDefaultMessage());
    }

    // Handle generic Exception and return an ErrorResponse with HTTP status 500 (Internal Server Error).
    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleException(Exception ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }
}
