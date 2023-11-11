package com.shsoftvina.erpshsoftvina.config;

import org.bouncycastle.jce.provider.BouncyCastleProvider;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.security.Security;


public class AppInitializer implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Security.addProvider(new BouncyCastleProvider());
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
