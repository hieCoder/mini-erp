package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.BookConverter;
import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.BookMapper;
import com.shsoftvina.erpshsoftvina.model.request.book.BookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.book.BookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.book.BookResponse;
import com.shsoftvina.erpshsoftvina.service.BookService;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private BookConverter bookConverter;

    @Override
    public List<BookResponse> findAll() {
        return bookMapper.findAll().stream().map(book -> bookConverter.toResponse(book)).collect(Collectors.toList());
    }

    @Override
    public BookResponse createBook(BookCreateRequest bookCreateRequest) {
        Book book = bookConverter.toEntity(bookCreateRequest);
        try{
            bookMapper.createBook(book);
        } catch (Exception e){
            return null;
        }
        return bookConverter.toResponse(book);
    }

    @Override
    public BookResponse findById(String id) {
        return bookConverter.toResponse(bookMapper.findById(id));
    }

    @Override
    public BookResponse updateBook(BookUpdateRequest bookUpdateRequest) {

        if(bookMapper.findById(bookUpdateRequest.getId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        Book book = bookConverter.toEntity(bookUpdateRequest);
        try{
            bookMapper.updateBook(book);
        } catch (Exception e){
            return null;
        }
        return bookConverter.toResponse(book);
    }

    @Override
    public int deleteBook(String id) {

        if(bookMapper.findById(id) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        return bookMapper.deleteBook(id);
    }
}
