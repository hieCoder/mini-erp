//package com.shsoftvina.erpshsoftvina.api;
//
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.shsoftvina.erpshsoftvina.entity.FeelingOfBook;
//import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookCreateRequest;
//import com.shsoftvina.erpshsoftvina.model.request.feelingofbook.FeelingOfBookUpdateRequest;
//import com.shsoftvina.erpshsoftvina.model.response.feelingofbook.FeelingOfBookResponse;
//import com.shsoftvina.erpshsoftvina.service.FeelingOfBookService;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.springframework.http.MediaType;
//import org.springframework.test.web.servlet.MockMvc;
//import org.springframework.test.web.servlet.setup.MockMvcBuilders;
//import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
//import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
//import org.mockito.Mockito;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.MockitoAnnotations;
//
//import java.util.ArrayList;
//import java.util.List;
//
//public class FeelingOfBookApiTest {
//
//    @InjectMocks
//    private FeelingOfBookApi controller;
//
//    @Mock
//    private FeelingOfBookService feelingOfBookService;
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
//    public void testFindAll() throws Exception {
//        List<FeelingOfBookResponse> mockResponse = new ArrayList<>();
//        FeelingOfBookResponse feeling1 = new FeelingOfBookResponse();
//        feeling1.setId("1");
//        feeling1.setFullnameUser("Happy");
//        mockResponse.add(feeling1);
//
//        FeelingOfBookResponse feeling2 = new FeelingOfBookResponse();
//        feeling2.setId("2");
//        feeling2.setFullnameUser("Sad");
//        mockResponse.add(feeling2);
//
//        Mockito.when(feelingOfBookService.findAll()).thenReturn(mockResponse);
//
//        mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/feeling-of-book"))
//                .andExpect(MockMvcResultMatchers.status().isOk());
//    }
//
//    @Test
//    public void testFindById() throws Exception {
//        FeelingOfBookResponse mockResponse = new FeelingOfBookResponse();
//        mockResponse.setId("1");
//        mockResponse.setFullnameUser("Happy");
//
//        Mockito.when(feelingOfBookService.findById(Mockito.anyString())).thenReturn(mockResponse);
//
//        mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/feeling-of-book/123"))
//                .andExpect(MockMvcResultMatchers.status().isOk());
//    }
//
//    @Test
//    public void testCreateFeelingOfBook() throws Exception {
//        FeelingOfBookCreateRequest request = new FeelingOfBookCreateRequest();
//        // Thiết lập request theo nhu cầu của bạn.
//
//        FeelingOfBookResponse mockResponse = new FeelingOfBookResponse();
//        mockResponse.setId("1");
//        mockResponse.setFullnameUser("Happy");
//
//        Mockito.when(feelingOfBookService.createFeelingOfBook(Mockito.any(FeelingOfBookCreateRequest.class))).thenReturn(mockResponse);
//
//        mockMvc.perform(MockMvcRequestBuilders.post("/api/v1/feeling-of-book")
//                .contentType(MediaType.APPLICATION_JSON)
//                .content(new ObjectMapper().writeValueAsString(request)))
//                .andExpect(MockMvcResultMatchers.status().isOk());
//    }
//
//    @Test
//    public void testUpdateFeelingOfBook() throws Exception {
//        FeelingOfBookUpdateRequest request = new FeelingOfBookUpdateRequest();
//
//        FeelingOfBookResponse mockResponse = new FeelingOfBookResponse();
//        mockResponse.setId("1");
//        mockResponse.setFullnameUser("Happy");
//
//        Mockito.when(feelingOfBookService.updateFeelingOfBook(Mockito.any(FeelingOfBookUpdateRequest.class))).thenReturn(mockResponse);
//
//        mockMvc.perform(MockMvcRequestBuilders.put("/api/v1/feeling-of-book")
//                .contentType(MediaType.APPLICATION_JSON)
//                .content(new ObjectMapper().writeValueAsString(request)))
//                .andExpect(MockMvcResultMatchers.status().isOk());
//    }
//
//    @Test
//    public void testDeleteFeelingOfBook() throws Exception {
//        FeelingOfBookResponse mockResponse = new FeelingOfBookResponse();
//        mockResponse.setId("1");
//        mockResponse.setFullnameUser("Happy");
//
//        Mockito.when(feelingOfBookService.deleteFeelingOfBook(Mockito.anyString(), Mockito.anyString())).thenReturn(1);
//
//        mockMvc.perform(MockMvcRequestBuilders.delete("/api/v1/feeling-of-book/123"))
//                .andExpect(MockMvcResultMatchers.status().isOk());
//    }
//
//    @Test
//    public void testFindByUser() throws Exception {
//        FeelingOfBookResponse mockResponse = new FeelingOfBookResponse();
//        mockResponse.setId("1");
//        mockResponse.setFullnameUser("Happy");
//
//        Mockito.when(feelingOfBookService.findFeelingByUser(Mockito.anyString(), Mockito.anyString())).thenReturn(mockResponse);
//
//        mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/feeling-of-book/123/456"))
//                .andExpect(MockMvcResultMatchers.status().isOk());
//    }
//}