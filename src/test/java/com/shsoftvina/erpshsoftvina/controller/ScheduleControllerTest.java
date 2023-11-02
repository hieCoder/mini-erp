//package com.shsoftvina.erpshsoftvina.controller;
//
//import com.shsoftvina.erpshsoftvina.model.response.schedule.ScheduleListResponse;
//import com.shsoftvina.erpshsoftvina.service.ScheduleService;
//import com.shsoftvina.erpshsoftvina.service.UserService;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.springframework.test.web.servlet.MockMvc;
//import org.springframework.test.web.servlet.setup.MockMvcBuilders;
//import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
//import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
//import org.mockito.Mockito;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.MockitoAnnotations;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.List;
//import java.util.Map;
//
//public class ScheduleControllerTest {
//
//    @InjectMocks
//    private ScheduleController controller;
//
//    @Mock
//    private ScheduleService scheduleService;
//
//    @Mock
//    private UserService userService;
//
//    private MockMvc mockMvc;
//
//    @BeforeEach
//    public void setUp() {
//        MockitoAnnotations.initMocks(this);
//        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
//    }
//
//    @Test
//    public void testGetScheduleList() throws Exception {
//        List<Map<String, Object>> mockList = new ArrayList<>();
//        Mockito.when(userService.getAllFullname()).thenReturn(mockList);
//
//        mockMvc.perform(MockMvcRequestBuilders.get("/schedules"))
//                .andExpect(MockMvcResultMatchers.status().isOk())
//                .andExpect(MockMvcResultMatchers.view().name("schedule/list"))
//                .andExpect(MockMvcResultMatchers.model().attributeExists("list"));
//    }
//
//    @Test
//    public void testGetScheduleDetail() throws Exception {
//        ScheduleListResponse mockResponse = new ScheduleListResponse();
//        Mockito.when(scheduleService.getScheduleDetail(Mockito.anyString(), Mockito.any(Date.class), Mockito.any(Date.class))).thenReturn(mockResponse);
//
//        mockMvc.perform(MockMvcRequestBuilders.get("/schedules/detail/123"))
//                .andExpect(MockMvcResultMatchers.status().isOk())
//                .andExpect(MockMvcResultMatchers.view().name("schedule/detail"))
//                .andExpect(MockMvcResultMatchers.model().attributeExists("schedule"));
//    }
//}
