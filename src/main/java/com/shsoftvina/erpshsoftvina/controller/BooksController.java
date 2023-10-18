package com.shsoftvina.erpshsoftvina.controller;

import com.shsoftvina.erpshsoftvina.entity.Book;
import com.shsoftvina.erpshsoftvina.model.response.book.PageBookListRespone;
import com.shsoftvina.erpshsoftvina.model.response.book.ShowBookResponse;
import com.shsoftvina.erpshsoftvina.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("/books")
public class BooksController {

    @Autowired
    BookService bookService;

    @GetMapping
    public ModelAndView books(@RequestParam(name = "search", required = false, defaultValue = "") String search,
                              @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                              @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize) {
        ModelAndView view = new ModelAndView("/books/books");

        PageBookListRespone books = bookService.fillAll(search, page, pageSize);

        view.addObject("books", books);
        return view;
    }

}
