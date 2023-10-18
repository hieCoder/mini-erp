package com.shsoftvina.erpshsoftvina.mapper;


import com.shsoftvina.erpshsoftvina.entity.Book;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookMapper {
    List<Book> findAll();
    int createBook(Book book);
    Book findById(String id);
    int updateBook(Book book);
    int deleteBook(String id);
}