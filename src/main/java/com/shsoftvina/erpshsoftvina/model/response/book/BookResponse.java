package com.shsoftvina.erpshsoftvina.model.response.book;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookResponse {

    private String id;
    private String title;
    private String author;
    private String link;
}