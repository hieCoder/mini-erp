package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.model.request.book.BookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.book.BookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.book.BookResponse;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class BookConverter {

    public BookResponse toResponse(Book book) {
        return BookResponse.builder()
                .id(book.getId())
                .title(book.getTitle())
                .author(book.getAuthor())
                .link(book.getLink()).build();
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