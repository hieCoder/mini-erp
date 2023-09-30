package com.shsoftvina.erpshsoftvina.security;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

// The @Service annotation marks this class as a Spring service component,
// allowing it to be automatically discovered and managed by the Spring container.
@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    // Inject an instance of UserMapper using Dependency Injection.
    @Autowired
    private UserMapper userMapper;

    // The loadUserByUsername method is part of the UserDetailsService interface
    // and is used to load a user's details by their username.
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        // Retrieve a user from the database using the provided username.
        User user = userMapper.findByEmailAndStatus(email, StatusUserEnum.ACTIVE.toString());

        // If the user is not found, throw a UsernameNotFoundException.
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }

        // Return the user, which is typically an instance of your custom User class
        // that implements the UserDetails interface and represents the authenticated user.
        return user;
    }
}
