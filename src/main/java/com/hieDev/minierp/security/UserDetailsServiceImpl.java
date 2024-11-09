package com.hieDev.minierp.security;

import com.hieDev.minierp.exception.UserLockException;
import com.hieDev.minierp.exception.UserNotFoundException;
import com.hieDev.minierp.exception.UserPendingException;
import com.hieDev.minierp.entity.User;
import com.hieDev.minierp.enums.user.StatusUserEnum;
import com.hieDev.minierp.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userMapper.findByEmail(email);

        if (user == null) {
            throw new UserNotFoundException("User is not found");
        } else{
            if(user.getStatus().equals(StatusUserEnum.INACTIVE)){
                throw new UserLockException("User is lock");
            } else if(user.getStatus().equals(StatusUserEnum.PENDING)){
                throw new UserPendingException("User is pending");
            }
        }

        return user;
    }
}
