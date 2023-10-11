package com.shsoftvina.erpshsoftvina.model.response.oc_and_tl;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OCAndTLOfOneDayResponse {
    private String day;
    Map<String, SpecificWorkOfCategoryInOCAndTLResponse> categorys;
}