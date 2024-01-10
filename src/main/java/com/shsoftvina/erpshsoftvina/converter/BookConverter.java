package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.model.request.book.BookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.book.BookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.book.BookResponse;
import com.shsoftvina.erpshsoftvina.utils.ApplicationUtils;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.JsonUtils;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class BookConverter {

    public BookResponse toResponse(Book book) {
        return BookResponse.builder()
                .id(book.getId())
                .title(book.getTitle())
                .author(book.getAuthor())
                .createdDate(DateUtils.formatDateTime(book.getCreatedDate()))
                .createdBy(book.getCreatedBy())
                .link(book.getLink())
                .image(FileUtils.getPathUpload(Book.class, book.getImage()))
                .timeSpentReading(book.getFeelingOfBook() == null ? 0 : book.getFeelingOfBook().getTimeSpentReading())
                .note(book.getFeelingOfBook() == null ? "" : book.getFeelingOfBook().getNote())
                .build();
    }

    public List<BookResponse> toListResponse(List<Book> books) {
        return books.stream().map(this::toResponse).collect(Collectors.toList());
    }

    public Book toEntity(BookCreateRequest bookCreateRequest, String bookImageFileName){
        return Book.builder()
                .id(ApplicationUtils.generateId())
                .title(bookCreateRequest.getTitle())
                .author(bookCreateRequest.getAuthor())
                .link(bookCreateRequest.getLink())
                .createdDate(new Date())
                .createdBy(bookCreateRequest.getFullnameUser())
                .image(bookImageFileName)
                .build();
    }

    public Book toEntity(BookUpdateRequest bookUpdateRequest, String bookImageFileName){
        return Book.builder()
                .id(bookUpdateRequest.getId())
                .title(bookUpdateRequest.getTitle())
                .author(bookUpdateRequest.getAuthor())
                .link(bookUpdateRequest.getLink())
                .image(bookImageFileName)
                .build();
    }
}