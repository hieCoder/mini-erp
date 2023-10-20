package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import com.shsoftvina.erpshsoftvina.service.AuthService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

public class AuthApiTest {

    @InjectMocks
    private AuthApi authApi;

    @Mock
    private AuthService authService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testRegisterUser() {
        UserRegisterRequest userRegisterRequest = new UserRegisterRequest();

        when(authService.registerUser(userRegisterRequest)).thenReturn(1);

        ResponseEntity<?> responseEntity = authApi.registerUser(userRegisterRequest);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }
}
