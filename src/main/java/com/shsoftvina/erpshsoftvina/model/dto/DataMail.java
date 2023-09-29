package com.shsoftvina.erpshsoftvina.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DataMail {
    private String to;
    private String subject;
    private String content;
}
