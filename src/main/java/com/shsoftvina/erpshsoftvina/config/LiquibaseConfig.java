package com.shsoftvina.erpshsoftvina.config;

import liquibase.integration.spring.SpringLiquibase;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

// Annotating this class with @Configuration designates it as a configuration class,
// allowing it to define Spring beans, configurations, and other application setup.
@Configuration
public class LiquibaseConfig {

    // Inject the Liquibase change log file path from application.properties using @Value annotation.
    @Value("${liquibase.changeLog}")
    private String liquibaseChangeLog;

    // Define a bean for SpringLiquibase, which manages database schema changes with Liquibase.
    @Bean
    public SpringLiquibase liquibase(DataSource dataSource) {
        // Create a SpringLiquibase instance.
        SpringLiquibase liquibase = new SpringLiquibase();

        // Set the Liquibase change log file path based on the injected property.
        liquibase.setChangeLog(liquibaseChangeLog);

        // Set the DataSource that Liquibase will use for database operations.
        liquibase.setDataSource(dataSource);

        // Specify the execution contexts for Liquibase (e.g., development, production).
        liquibase.setContexts("development, production");

        // Set 'shouldRun' to true, so Liquibase will execute database changes on application startup.
        liquibase.setShouldRun(true);

        // Return the configured SpringLiquibase bean.
        return liquibase;
    }
}
