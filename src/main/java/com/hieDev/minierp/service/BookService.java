package com.hieDev.minierp.service;

import com.hieDev.minierp.model.request.book.BookCreateRequest;
import com.hieDev.minierp.model.request.book.BookUpdateRequest;
import com.hieDev.minierp.model.response.book.BookResponse;

import java.util.List;

public interface BookService {
    List<BookResponse> findAll(String searchTerm, int start, int pageSize);
    long getTotalItem(String search);
    int createBook(BookCreateRequest bookCreateRequest);
    BookResponse findById(String id);
    int updateBook(BookUpdateRequest bookUpdateRequest);
    int deleteBook(String id);
}