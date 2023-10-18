package com.shsoftvina.erpshsoftvina.service.impl;

import com.shsoftvina.erpshsoftvina.converter.BookConverter;
import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.mapper.BookMapper;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.book.BookCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.book.BookUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.book.BookDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.book.ShowBookResponse;
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

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<ShowBookResponse> findAll() {
        return bookMapper.findAll().stream().map(book -> bookConverter.toShowResponse(book)).collect(Collectors.toList());
    }

    @Override
    public ShowBookResponse createBook(BookCreateRequest bookCreateRequest) {

        Book book = bookConverter.toEntity(bookCreateRequest);
        try{
            bookMapper.createBook(book);
        } catch (Exception e){
            return null;
        }
        return bookConverter.toShowResponse(book);
    }

    @Override
    public BookDetailResponse findById(String id) {
        return bookConverter.toDetailResponse(bookMapper.findById(id));
    }

    @Override
    public ShowBookResponse updateBook(BookUpdateRequest bookUpdateRequest) {

        if(bookMapper.findById(bookUpdateRequest.getId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        Book book = bookConverter.toEntity(bookUpdateRequest);
        try{
            bookMapper.updateBook(book);
        } catch (Exception e){
            return null;
        }
        return bookConverter.toShowResponse(book);
    }

    @Override
    public int deleteBook(String id) {

        if(bookMapper.findById(id) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        return bookMapper.deleteBook(id);
    }
}
