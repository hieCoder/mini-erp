package com.shsoftvina.erpshsoftvina.config;


import com.shsoftvina.erpshsoftvina.security.UpdateProfileInterceptorFilter;
import com.shsoftvina.erpshsoftvina.security.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.Filter;

// Annotating this class with @Configuration designates it as a configuration class,
// allowing it to define Spring beans, configurations, and other application setup.
@Configuration
// The @EnableWebSecurity annotation is used to enable Spring Security configuration for the application.
// It indicates that the application should use Spring Security to handle web security-related features
// such as authentication, authorization, and protection against common security vulnerabilities.
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UpdateProfileInterceptorFilter updateProfileInterceptorFilter;

    // Configure security for HTTP requests.
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                // Allow unrestricted access to specific endpoints.
                .antMatchers("/upload/**").permitAll() // resource
                .antMatchers("/assets/**").permitAll() // css, js
                .antMatchers("/api/**").permitAll() // api
                .antMatchers("/login", "/register").permitAll()// controller
                // Require authentication for all other requests.
                .anyRequest().authenticated()
                .and()
                // Configure form-based login.
                .formLogin()
//                .loginPage("/login") // Specify the login page URL.
//                .usernameParameter("username") // Define the parameter name for the username field.
//                .passwordParameter("password") // Define the parameter name for the password field.
//                .defaultSuccessUrl("/home") // Redirect to this URL after successful login.
//                .loginProcessingUrl("/j_spring_security_check").permitAll() // URL for login processing.
//                .failureUrl("/login?incorrectAccount") // URL for login failure.
//                .and()
//                // Configure logout.
//                .logout()
//                .logoutUrl("/logout") // URL for logout.
//                .logoutSuccessUrl("/login?logout") // URL after successful logout.
//                .permitAll()
              .and()
                .addFilterBefore(updateProfileInterceptorFilter, UsernamePasswordAuthenticationFilter.class)
              .csrf().disable(); // Disable CSRF protection.
    }

    // Inject the userDetailsService for authentication.
    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    // Define a bean for passwordEncoder, which is used for password hashing.
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // Configure authentication manager with userDetailsService and passwordEncoder.
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }
}