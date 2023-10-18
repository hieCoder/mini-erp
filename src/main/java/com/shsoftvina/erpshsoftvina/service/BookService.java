package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.book.BookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.book.BookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.book.BookDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.book.ShowBookResponse;

import java.util.List;

public interface BookService {
    List<ShowBookResponse> findAll();
    ShowBookResponse createBook(BookCreateRequest bookCreateRequest);
    BookDetailResponse findById(String id);
    ShowBookResponse updateBook(BookUpdateRequest bookUpdateRequest);
    int deleteBook(String id);
}