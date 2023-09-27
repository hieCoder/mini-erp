package com.shsoftvina.erpshsoftvina.ultis;

import com.shsoftvina.erpshsoftvina.model.request.DataMailDTO;
import com.shsoftvina.erpshsoftvina.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;

@Component
public class SendMailUlti {
    @Autowired
    private MailService mailService;
    public Boolean sendEmail(DataMailDTO dataMailDTO) {
        try {
            mailService.sendMail(dataMailDTO);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return false;
    }
}
