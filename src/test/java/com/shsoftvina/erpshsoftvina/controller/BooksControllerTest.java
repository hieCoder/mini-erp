package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.model.response.book.BookDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.book.PageBookListRespone;
import com.shsoftvina.erpshsoftvina.service.BookService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.mockito.Mockito;

public class BooksControllerTest {

    @InjectMocks
    private BooksController controller;

    @Mock
    private BookService bookService;

    private MockMvc mockMvc;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
    }

    @Test
    public void testBooks() throws Exception {
        PageBookListRespone mockResponse = new PageBookListRespone();
        Mockito.when(bookService.fillAll(Mockito.anyString(), Mockito.anyInt(), Mockito.anyInt())).thenReturn(mockResponse);

        mockMvc.perform(MockMvcRequestBuilders.get("/books"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.view().name("/books/books"))
                .andExpect(MockMvcResultMatchers.model().attributeExists("books"));
    }

    @Test
    public void testBookDetail() throws Exception {
        // Tạo dữ liệu giả lập cho bookService.findById
        BookDetailResponse mockResponse = new BookDetailResponse();
        Mockito.when(bookService.findById(Mockito.anyString())).thenReturn(mockResponse);

        mockMvc.perform(MockMvcRequestBuilders.get("/books/123"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.view().name("/books/bookDetail"))
                .andExpect(MockMvcResultMatchers.model().attributeExists("bookDetail"));
    }
}