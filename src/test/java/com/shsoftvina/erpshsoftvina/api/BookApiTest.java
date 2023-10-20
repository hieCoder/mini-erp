package com.shsoftvina.erpshsoftvina.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.model.request.book.BookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.book.BookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.book.BookDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.book.PageBookListRespone;
import com.shsoftvina.erpshsoftvina.service.BookService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.mockito.Mockito;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.List;

public class BookApiTest {

    @InjectMocks
    private BookApi controller;

    @Mock
    private BookService bookService;

    private MockMvc mockMvc;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
    }

    @Test
    public void testFindAll() throws Exception {
        Mockito.when(bookService.fillAll(Mockito.anyString(), Mockito.anyInt(), Mockito.anyInt())).thenReturn(new PageBookListRespone());

        mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/books"))
                .andExpect(MockMvcResultMatchers.status().isOk());
    }

    @Test
    public void testFindById() throws Exception {
        // Tạo dữ liệu giả lập cho bookService.findById
        BookDetailResponse mockResponse = new BookDetailResponse();

        Mockito.when(bookService.findById(Mockito.anyString())).thenReturn(mockResponse);

        mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/books/123"))
                .andExpect(MockMvcResultMatchers.status().isOk());
    }

    @Test
    public void testCreateBook() throws Exception {
        BookCreateRequest request = new BookCreateRequest();

        Mockito.when(bookService.createBook(Mockito.any(BookCreateRequest.class))).thenReturn(1);

        mockMvc.perform(MockMvcRequestBuilders.post("/api/v1/books")
                .contentType(MediaType.APPLICATION_JSON)
                .content(new ObjectMapper().writeValueAsString(request)))
                .andExpect(MockMvcResultMatchers.status().isOk());
    }

    @Test
    public void testUpdateBook() throws Exception {
        BookUpdateRequest request = new BookUpdateRequest();

        Mockito.when(bookService.updateBook(Mockito.any(BookUpdateRequest.class))).thenReturn(1);

        mockMvc.perform(MockMvcRequestBuilders.post("/api/v1/books/update")
                .contentType(MediaType.APPLICATION_JSON)
                .content(new ObjectMapper().writeValueAsString(request)))
                .andExpect(MockMvcResultMatchers.status().isOk());
    }

    @Test
    public void testDeleteBook() throws Exception {

        Mockito.when(bookService.deleteBook(Mockito.anyString())).thenReturn(1);

        mockMvc.perform(MockMvcRequestBuilders.delete("/api/v1/books/123"))
                .andExpect(MockMvcResultMatchers.status().isOk());
    }
}
