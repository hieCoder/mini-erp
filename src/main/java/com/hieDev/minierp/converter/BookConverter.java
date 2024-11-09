package com.hieDev.minierp.converter;

import com.hieDev.minierp.entity.Book;
import com.hieDev.minierp.model.request.book.BookCreateRequest;
import com.hieDev.minierp.model.request.book.BookUpdateRequest;
import com.hieDev.minierp.model.response.book.BookResponse;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.DateUtils;
import com.hieDev.minierp.utils.FileUtils;
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
                .timeSpentReading(book.getFeelingOfBook() == null || book.getFeelingOfBook().getTimeSpentReading() == null ? 0 : book.getFeelingOfBook().getTimeSpentReading())
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