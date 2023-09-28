package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.DataMailDTO;

import javax.mail.MessagingException;

public interface MailService {
    void sendMail(DataMailDTO dataMailDTO) throws MessagingException;
}
