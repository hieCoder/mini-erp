package com.shsoftvina.erpshsoftvina.model.response.managementtime.day;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QuoteResponse {
    private String id;
    private String[] content;
    private String image;
}
