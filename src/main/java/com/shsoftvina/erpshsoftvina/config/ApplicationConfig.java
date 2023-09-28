package com.shsoftvina.erpshsoftvina.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

// Annotating this class with @Configuration designates it as a configuration class,
// allowing it to define Spring beans, configurations, and other application setup.
@Configuration
// Use @PropertySource to specify the location of the properties file 'application.properties'
// from which configuration properties will be loaded into the Spring application context.
@PropertySource("classpath:application.properties")
public class ApplicationConfig {
}
