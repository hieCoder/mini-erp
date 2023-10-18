package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.mapper.FeelingOfBookMapper;
import com.shsoftvina.erpshsoftvina.model.request.book.BookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.book.BookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.book.BookDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.book.ShowBookResponse;
import com.shsoftvina.erpshsoftvina.model.response.feelingofbook.FeelingOfBookResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.UUID;

@Component
public class BookConverter {

    @Autowired
    private FeelingOfBookConverter feelingOfBookConverter;

    public ShowBookResponse toShowResponse(Book book) {
        return ShowBookResponse.builder()
                .id(book.getId())
                .title(book.getTitle())
                .author(book.getAuthor())
                .link(book.getLink()).build();
    }

    public BookDetailResponse toDetailResponse(Book book) {
        return BookDetailResponse.builder()
                .book(new ShowBookResponse(book.getId(), book.getTitle(), book.getAuthor(), book.getLink()))
                .feelingOfBooks(feelingOfBookConverter.toListResponse(book.getFeelingOfBooks())).build();
    }

    public Book toEntity(BookCreateRequest bookCreateRequest){
        return Book.builder()
                .id(UUID.randomUUID().toString())
                .title(bookCreateRequest.getTitle())
                .author(bookCreateRequest.getAuthor())
                .link(bookCreateRequest.getLink()).build();
    }

    public Book toEntity(BookUpdateRequest bookUpdateRequest){
        return Book.builder()
                .id(bookUpdateRequest.getId())
                .title(bookUpdateRequest.getTitle())
                .author(bookUpdateRequest.getAuthor())
                .link(bookUpdateRequest.getLink()).build();
    }
}