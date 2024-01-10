package com.shsoftvina.erpshsoftvina.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

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
    private Double timeSpentReading;
    private String note;
    private Book book;
    private List<CommentFeelingBook> comments;
}