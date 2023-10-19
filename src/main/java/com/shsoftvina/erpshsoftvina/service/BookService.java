package com.shsoftvina.erpshsoftvina.service;

import com.shsoftvina.erpshsoftvina.model.request.book.BookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.book.BookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.book.BookDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.book.PageBookListRespone;
import com.shsoftvina.erpshsoftvina.model.response.book.ShowBookResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.PageUserListRespone;

import java.util.List;

public interface BookService {
    PageBookListRespone fillAll(String searchTerm,
                              int start,
                              int pageSize);
    int createBook(BookCreateRequest bookCreateRequest);
    BookDetailResponse findById(String id);
    int updateBook(BookUpdateRequest bookUpdateRequest);
    int deleteBook(String id);
}