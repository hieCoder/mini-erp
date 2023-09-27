package com.shsoftvina.erpshsoftvina.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

// Annotating this class with @Configuration designates it as a configuration class,
// allowing it to define Spring beans, configurations, and other application setup.
@Configuration
// Use @PropertySource to specify the location of the properties file 'application.properties'
// from which configuration properties will be loaded into the Spring application context.
@PropertySource("classpath:application.properties")
public class ApplicationConfig {
    @Value("${mailServer.host}")
    private String host;

    @Value("${mailServer.port}")
    private Integer port;

    @Value("${mailServer.email}")
    private String email;

    @Value("${mailServer.password}")
    private String password;

    @Value("${mailServer.isSSL}")
    private String isSSL;
    @Bean
    public JavaMailSender getJavaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(host);
        mailSender.setPort(port);
        mailSender.setUsername(email);
        mailSender.setPassword(password);
        mailSender.setDefaultEncoding("UTF-8");

        Properties properties = mailSender.getJavaMailProperties();
        properties.put("mail.smtp.starttls.enable","true");
        properties.put("mail.smtp.auth","true");
        properties.put("mail.transport.protocol","smtp");
        properties.put("mail.debug","true");
        properties.put("mail.smtp.from",email);
        properties.put("mail.smtp.ssl.enable",isSSL);

        return mailSender;
    }

}
