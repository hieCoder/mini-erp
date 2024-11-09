package com.hieDev.minierp.mapper;


import com.hieDev.minierp.entity.Book;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface BookMapper {
    List<Book> findAll(String searchTerm, RowBounds rowBounds);
    long totalBook(String searchTerm);

    int createBook(Book book);

    Book findById(String id);

    int updateBook(Book book);

    int deleteBook(String id);
}