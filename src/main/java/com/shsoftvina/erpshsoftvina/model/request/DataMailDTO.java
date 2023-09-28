package com.shsoftvina.erpshsoftvina.model.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DataMailDTO {
    private String to;
    private String subject;
    private String content;
}
