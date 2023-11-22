package com.shsoftvina.erpshsoftvina.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FeelingOfBook {

    private String id;
    private User user;
    private String feeling;
    private String quote;
    private String lesson;
    private String action;
    private Date createdDate;
    private Book book;
}