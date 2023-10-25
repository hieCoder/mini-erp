package com.shsoftvina.erpshsoftvina.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@RestControllerAdvice
public class CustomExceptionHandler {

    @ExceptionHandler(UnauthorizedException.class)
    public void handleUnauthorizedException(HttpServletResponse response) throws IOException {
        response.sendRedirect("/forbidden");
    }

    @ExceptionHandler(DuplicateException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public ErrorResponse handleDuplicateException(DuplicateException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.CONFLICT, ex.getMessage());
    }

    @ExceptionHandler(FileTooLimitedException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleFileTooLimitedException(FileTooLimitedException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(NotFoundException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleNotFoundException(NotFoundException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(NoMatchException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleNoMatchException(NoMatchException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(FileTypeNotAllowException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleFileTypeNotAllowException(FileTypeNotAllowException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(FileSizeNotAllowException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleFileSizeNotAllowException(FileSizeNotAllowException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(FileLimitNotAllowException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleFileLimitNotAllowException(FileLimitNotAllowException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(NotAllowException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleNotAllowException(NotAllowException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handleMethodArgumentNotValidException(MethodArgumentNotValidException e, WebRequest req) {
        return new ErrorResponse(HttpStatus.BAD_REQUEST,
                e.getBindingResult().getAllErrors().get(0).getDefaultMessage());
    }

    @ExceptionHandler(ErrorConvertJsonException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handleErrorConvertJsonException(ErrorConvertJsonException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(InvalidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handleInvalidException(InvalidException ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleException(Exception ex, WebRequest req) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
    }
}
