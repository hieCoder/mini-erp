package com.shsoftvina.erpshsoftvina.config;


import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.security.UpdateProfileInterceptorFilter;
import com.shsoftvina.erpshsoftvina.security.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UpdateProfileInterceptorFilter updateProfileInterceptorFilter;

    @Override
    protected void configure(HttpSecurity http) throws Exception {

//        User user = Principal.getUserCurrent();
//        String roleCurrent = user.getRole().toString();
//
//        boolean isAllowAccess = true;
//
//        if(roleCurrent.equals("DEVELOPER"))

        String[] apiManagerOrOwner = new String[]{
                ,

        };


        http
                .authorizeRequests()
                .antMatchers("/upload/**").permitAll() // resource
                .antMatchers("/assets/**").permitAll() // css, js
                .antMatchers("/api/**").permitAll() // api
                .antMatchers("/login", "/register").permitAll()// controller

//                // api
//                    // auth
//                    .antMatchers("/api/v1/auth/**").permitAll()
//                    // accounting
//                    .antMatchers("/api/v1/accounts/**").access("hasAnyRole('OWNER', 'MANAGER')")
//                    // timesheets
//                    .antMatchers("/api/v1/timesheets/**").access("hasAnyRole('OWNER', 'MANAGER')")
//                    // book
//                    .antMatchers(HttpMethod.GET, "/api/v1/books/**").authenticated()
//                    .antMatchers(HttpMethod.POST, "/api/v1/books/**").access("hasAnyRole('OWNER', 'MANAGER')")
//                    .antMatchers(HttpMethod.PUT, "/api/v1/books/**").access("hasAnyRole('OWNER', 'MANAGER')")
//                    .antMatchers(HttpMethod.DELETE, "/api/v1/books/**").access("hasAnyRole('OWNER', 'MANAGER')")
//                    // task
//                    .antMatchers(HttpMethod.POST, "/api/v1/tasks").authenticated()

                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .usernameParameter("username")
                .passwordParameter("password")
                .defaultSuccessUrl("/tasks")
                .loginProcessingUrl("/j_spring_security_check").permitAll()
                .failureUrl("/login?incorrectAccount")
                .and()
                .logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout")
                .permitAll()
              .and()
                .addFilterBefore(updateProfileInterceptorFilter, UsernamePasswordAuthenticationFilter.class)
              .csrf().disable();
    }

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }
}
