package com.shsoftvina.erpshsoftvina.exception;

import org.springframework.security.core.AuthenticationException;

public class WaitingApprovalException extends AuthenticationException {
    public WaitingApprovalException(String message) {
        super(message);
    }
}
