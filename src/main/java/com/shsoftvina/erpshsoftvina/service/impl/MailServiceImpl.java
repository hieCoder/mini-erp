package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.model.request.DataMail;
import com.shsoftvina.erpshsoftvina.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;

@Service
public class MailServiceImpl implements MailService {
    @Autowired
    JavaMailSender javaMailSender;
    @Override
    public void sendMail(DataMail dataMail) throws MessagingException {
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();

        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage,true,"utf-8");

        helper.setTo(dataMail.getTo());
        helper.setSubject(dataMail.getSubject());
        helper.setText(dataMail.getContent());

        javaMailSender.send(mimeMessage);
    }
}
