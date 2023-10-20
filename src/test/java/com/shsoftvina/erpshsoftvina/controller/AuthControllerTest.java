package com.shsoftvina.erpshsoftvina.controller;

import org.junit.jupiter.api.Test;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.ModelAndView;

import static org.junit.Assert.assertEquals;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

public class AuthControllerTest {

    @Test
    public void testLogin() throws Exception {
        AuthController authController = new AuthController();
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(authController).build();

        mockMvc.perform(MockMvcRequestBuilders.get("/login"))
                .andExpect(status().isOk())
                .andExpect(view().name("auth/login"));

        ModelAndView modelAndView = mockMvc.perform(MockMvcRequestBuilders.get("/login")).andReturn().getModelAndView();
        assertEquals("auth/login", modelAndView.getViewName());
    }

    @Test
    public void testRegister() throws Exception {
        AuthController authController = new AuthController();
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(authController).build();

        mockMvc.perform(MockMvcRequestBuilders.get("/register"))
                .andExpect(status().isOk())
                .andExpect(view().name("auth/register"));

        ModelAndView modelAndView = mockMvc.perform(MockMvcRequestBuilders.get("/register")).andReturn().getModelAndView();
        assertEquals("auth/register", modelAndView.getViewName());
    }
}
