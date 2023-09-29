package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.model.dto.DataMail;
import com.shsoftvina.erpshsoftvina.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;

@Component
public class SendMailUtils {

    @Autowired
    private MailService mailService;

    public Boolean sendEmail(DataMail dataMail) {
        try {
            mailService.sendMail(dataMail);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return false;
    }
}
