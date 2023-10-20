package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.converter.UserConverter;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.exception.DuplicateException;
import com.shsoftvina.erpshsoftvina.exception.NoMatchException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import com.shsoftvina.erpshsoftvina.service.impl.AuthServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

public class AuthServiceTest {

    @InjectMocks
    private AuthServiceImpl authService;

    @Mock
    private UserConverter userConverter;

    @Mock
    private UserMapper userMapper;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testRegisterUser_Success() {
        UserRegisterRequest request = new UserRegisterRequest();
        request.setFullname("sampleUser");
        request.setEmail("sampleEmail");
        request.setPassword("samplePassword");
        request.setConfirmPassword("samplePassword");

        when(userMapper.findByEmail("sampleEmail")).thenReturn(null);

        when(userConverter.toEntity(request)).thenReturn(new User());

        when(userMapper.registerUser(Mockito.any(User.class))).thenReturn(1);

        int result = authService.registerUser(request);

        assertEquals(1, result);
    }

    @Test
    public void testRegisterUser_PasswordNoMatch() {
        UserRegisterRequest request = new UserRegisterRequest();
        request.setFullname("sampleUser");
        request.setEmail("sampleEmail");
        request.setPassword("samplePassword");
        request.setConfirmPassword("differentPassword");

        NoMatchException exception = org.junit.jupiter.api.Assertions.assertThrows(NoMatchException.class, () -> {
            authService.registerUser(request);
        });

        assertEquals("Password confirm isn't matched", exception.getMessage());
    }

    @Test
    public void testRegisterUser_DuplicateUser() {
        UserRegisterRequest request = new UserRegisterRequest();
        request.setFullname("sampleUser");
        request.setEmail("sampleEmail");
        request.setPassword("samplePassword");
        request.setConfirmPassword("samplePassword");

        when(userMapper.findByEmail("sampleEmail")).thenReturn(new User());

        DuplicateException exception = org.junit.jupiter.api.Assertions.assertThrows(DuplicateException.class, () -> {
            authService.registerUser(request);
        });

        assertEquals("UserID is existed in the system", exception.getMessage());
    }
}
