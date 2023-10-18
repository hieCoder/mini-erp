package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.mapper.FeelingOfBookMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.book.BookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.book.BookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.book.BookDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.book.ShowBookResponse;
import com.shsoftvina.erpshsoftvina.model.response.feelingofbook.FeelingOfBookResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class BookConverter {

    @Autowired
    private FeelingOfBookConverter feelingOfBookConverter;

    @Autowired
    private FeelingOfBookMapper feelingOfBookMapper;

    public ShowBookResponse toShowBookResponse(Book book) {
        return ShowBookResponse.builder()
                .id(book.getId())
                .title(book.getTitle())
                .author(book.getAuthor())
                .createdDate(DateUtils.formatDateTime(book.getCreatedDate()))
                .createdBy(book.getCreatedBy())
                .link(book.getLink())
                .image(FileUtils.getPathUpload(Book.class, book.getImage()))
                .build();
    }

    public List<ShowBookResponse> toListShowBookResponse(List<Book> books) {
        return books.stream().map(this::toShowBookResponse).collect(Collectors.toList());
    }

    public BookDetailResponse toDetailResponse(Book book) {
        return BookDetailResponse.builder()
                .book(toShowBookResponse(book))
                .feelingOfBooks(feelingOfBookConverter.toListResponse(feelingOfBookMapper.findAllByBook(book.getId()))).build();
    }

    public Book toEntity(BookCreateRequest bookCreateRequest, String bookImageFileName){
        return Book.builder()
                .id(UUID.randomUUID().toString())
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