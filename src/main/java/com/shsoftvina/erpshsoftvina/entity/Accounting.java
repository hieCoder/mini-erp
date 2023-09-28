package com.shsoftvina.erpshsoftvina.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Accounting {
    private String id;
    private LocalDateTime createdDate;
    private Integer expense;
    private Integer remain;
    private User user;
    private String bill;
    private String title;
}
