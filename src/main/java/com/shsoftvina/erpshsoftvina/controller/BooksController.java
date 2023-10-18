package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.model.response.book.ShowBookResponse;
import com.shsoftvina.erpshsoftvina.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("/books")
public class BooksController {

    @Autowired
    BookService bookService;

    @GetMapping
    public ModelAndView books() {
        ModelAndView view = new ModelAndView("/books/books");

        List<ShowBookResponse> books = bookService.findAll();

        view.addObject("books", books);
        return view;
    }

}
