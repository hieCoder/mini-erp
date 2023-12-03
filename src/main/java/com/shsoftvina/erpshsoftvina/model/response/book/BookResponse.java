package com.shsoftvina.erpshsoftvina.model.response.book;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookResponse {

    private String id;
    private String title;
    private String author;
    private String createdDate;
    private String createdBy;
    private String link;
    private String image;
}