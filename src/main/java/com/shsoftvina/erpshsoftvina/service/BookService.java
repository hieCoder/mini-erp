package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.book.BookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.book.BookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.book.BookResponse;

import java.util.List;

public interface BookService {
    List<BookResponse> findAll(String searchTerm, int start, int pageSize);
    long getTotalItem(String search);
    int createBook(BookCreateRequest bookCreateRequest);
    BookResponse findById(String id);
    int updateBook(BookUpdateRequest bookUpdateRequest);
    int deleteBook(String id);
}