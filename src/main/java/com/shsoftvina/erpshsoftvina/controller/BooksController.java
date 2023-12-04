package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/books")
public class BooksController {

    @Autowired
    BookService bookService;

    @GetMapping
    public ModelAndView books() {
        ModelAndView view = new ModelAndView("/books/books");
        return view;
    }

    @GetMapping("/{id}")
    public ModelAndView bookDetail(@PathVariable("id") String id) {
        ModelAndView view = new ModelAndView("/books/bookDetail");
        view.addObject("bookId", id);
        return view;
    }
}
