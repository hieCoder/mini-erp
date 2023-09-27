package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.DataMail;

import javax.mail.MessagingException;

public interface MailService {
    void sendMail(DataMail dataMail) throws MessagingException;
}
