package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.model.request.DataMailDTO;
import com.shsoftvina.erpshsoftvina.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
public class MailServiceImpl implements MailService {
    @Autowired
    JavaMailSender javaMailSender;
    @Override
    public void sendMail(DataMailDTO dataMailDTO) throws MessagingException {
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();

        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage,true,"utf-8");

        helper.setTo(dataMailDTO.getTo());
        helper.setSubject(dataMailDTO.getSubject());
        helper.setText(dataMailDTO.getContent());

        javaMailSender.send(mimeMessage);
    }
}
