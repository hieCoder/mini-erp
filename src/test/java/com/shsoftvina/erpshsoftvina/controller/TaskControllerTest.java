//package com.shsoftvina.erpshsoftvina.controller;
//
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.springframework.test.web.servlet.MockMvc;
//import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
//import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
//import org.springframework.test.web.servlet.setup.MockMvcBuilders;
//
//public class TaskControllerTest {
//
//    private TaskController taskController;
//
//    @BeforeEach
//    public void setUp() {
//        taskController = new TaskController();
//    }
//
//    @Test
//    public void testGetTasks() throws Exception {
//        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(taskController).build();
//        mockMvc.perform(MockMvcRequestBuilders.get("/tasks"))
//                .andExpect(MockMvcResultMatchers.status().isOk())
//                .andExpect(MockMvcResultMatchers.view().name("task/tasks"));
//    }
//
//    @Test
//    public void testGetTask() throws Exception {
//        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(taskController).build();
//        String taskId = "sampleTaskId";
//        mockMvc.perform(MockMvcRequestBuilders.get("/tasks/{id}", taskId))
//                .andExpect(MockMvcResultMatchers.status().isOk())
//                .andExpect(MockMvcResultMatchers.view().name("task/task-detail"))
//                .andExpect(MockMvcResultMatchers.model().attribute("id", taskId));
//    }
//}
