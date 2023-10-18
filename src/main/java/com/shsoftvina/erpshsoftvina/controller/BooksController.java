package com.shsoftvina.erpshsoftvina.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/books")
public class BooksController {

    @GetMapping
    public ModelAndView books() {
        ModelAndView view = new ModelAndView("/books/books");

        return view;
    }

}
