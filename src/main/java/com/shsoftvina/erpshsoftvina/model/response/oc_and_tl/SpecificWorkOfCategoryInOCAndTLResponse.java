package com.shsoftvina.erpshsoftvina.model.response.oc_and_tl;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SpecificWorkOfCategoryInOCAndTLResponse {
    private String id;
    private String target;
    private boolean performance;
}