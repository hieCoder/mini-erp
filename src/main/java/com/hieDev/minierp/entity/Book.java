package com.hieDev.minierp.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book {

    private String id;
    private String title;
    private String author;
    private String link;
    private Date createdDate;
    private String createdBy;
    private String image;
    private FeelingOfBook feelingOfBook;
}