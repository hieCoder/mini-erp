package com.shsoftvina.erpshsoftvina.utils;

import com.shsoftvina.erpshsoftvina.model.dto.DataMail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Component
public class SendMailUtils {

    @Autowired
    JavaMailSender javaMailSender;

    public Boolean sendEmail(DataMail dataMail) {
        try {
            MimeMessage mimeMessage = javaMailSender.createMimeMessage();

            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage,true,"utf-8");

            helper.setTo(dataMail.getTo());
            helper.setSubject(dataMail.getSubject());
            helper.setText(dataMail.getContent());

            javaMailSender.send(mimeMessage);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return false;
    }
}
